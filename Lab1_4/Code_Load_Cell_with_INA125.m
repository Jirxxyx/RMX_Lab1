% =========================================================================
% สคริปต์เก็บข้อมูล Calibration กึ่งอัตโนมัติ (มีระบบ Set Zero / Tare)
% =========================================================================

% 1. โหลดค่าน้ำหนักเป้าหมายจากไฟล์ 'น้ามหนาก.csv'
try
    T = readtable('น้ามหนาก.csv');
    % ดึงข้อมูลจากคอลัมน์ที่ 3 
    target_weights = T{:, 3}; 
catch
    disp('⚠️ ไม่พบไฟล์ น้ามหนาก.csv หรือไฟล์มีปัญหา จะใช้ค่าเริ่มต้น 0, 50, 100... แทน');
    target_weights = [0; 50; 100; 150; 200; 250; 300]; 
end

% 2. เตรียมตัวแปร
weight_array = [];
volt_array = [];
current_step = 1; 
v_zero_offset = 0; % ตัวแปรสำหรับเก็บค่า Set Zero เริ่มต้นที่ 0

% *** ชื่อไฟล์โมเดล Simulink ***
model_name = 'loadcell'; 

disp('=== เริ่มโปรแกรมเก็บข้อมูล Calibration สำหรับ Load Cell ===');

% 3. เริ่มลูปวนรับคำสั่งจากผู้ใช้งาน
while true
    fprintf('\n----------------------------------------------------\n');
    if current_step <= length(target_weights)
        current_w = target_weights(current_step);
        fprintf('🎯 เป้าหมายต่อไป: กรุณาวางน้ำหนัก [ %d กรัม ] ลงบนเซ็นเซอร์\n', current_w);
    else
        current_w = NaN;
        fprintf('✅ คุณทำการวัดครบทุกค่าน้ำหนักในตารางแล้ว!\n');
    end
    
    % เพิ่มปุ่ม [Z] ในเมนูคำสั่ง
    fprintf('[Z] เซ็ตศูนย์ (Tare) | [J] เก็บค่า 50 จุด | [K] ลบค่าล่าสุด | [C] ล้างค่าทั้งหมด | [L] ออกและสร้างกราฟ\n');
    
    cmd = input('พิมพ์คำสั่งแล้วกด Enter: ', 's');
    cmd = upper(strtrim(cmd)); 
    
    if strcmp(cmd, 'Z')
        % ---------------- ระบบ Set Zero ----------------
        disp('⚖️ กำลังรัน Simulink เพื่อเซ็ตศูนย์... (กรุณาเอาของออกจากเซ็นเซอร์ให้หมด)');
        try
            out = sim(model_name);
            y_all = out.y_volt;
            
            if length(y_all) >= 50
                y_50_points = y_all(end-49:end); 
            else
                y_50_points = y_all; 
            end
            
            % บันทึกค่าเฉลี่ยเป็นค่า Offset
            v_zero_offset = mean(y_50_points); 
            fprintf('✔️ เซ็ตศูนย์สำเร็จ! ค่าอ้างอิงปัจจุบันคือ %.4f โวลต์\n', v_zero_offset);
        catch ME
            disp('❌ รัน Simulink ไม่สำเร็จ! กรุณาเช็คชื่อไฟล์โมเดลหรือการเชื่อมต่อบอร์ด');
            disp(ME.message);
        end
        
    elseif strcmp(cmd, 'J')
        % ---------------- ระบบเก็บค่า ----------------
        if isnan(current_w)
            disp('ไม่มีค่าน้ำหนักเป้าหมายให้เก็บแล้ว กรุณากด L เพื่อออกครับ');
            continue;
        end
        disp('⏳ กำลังสั่งรัน Simulink เพื่อเก็บข้อมูล 50 จุด... (ห้ามขยับของ)');
        
        try
            out = sim(model_name);
            
            y_all = out.y_volt;
            if length(y_all) >= 50
                y_50_points = y_all(end-49:end); 
            else
                y_50_points = y_all; 
            end
            
            % นำค่าที่อ่านได้ มาลบกับค่า Zero Offset
            avg_v = mean(y_50_points) - v_zero_offset; 
            
            weight_array = [weight_array; current_w];
            volt_array = [volt_array; avg_v];
            
            fprintf('✔ บันทึกสำเร็จ: น้ำหนัก %d กรัม = %.4f โวลต์ (หัก Zero แล้ว)\n', current_w, avg_v);
            current_step = current_step + 1; 
        catch ME
            disp('❌ รัน Simulink ไม่สำเร็จ!');
            disp(ME.message);
        end
        
    elseif strcmp(cmd, 'K')
        if ~isempty(weight_array)
            fprintf('🗑️ ลบค่าล่าสุด (น้ำหนัก %d กรัม, แรงดัน %.4f V) ออกแล้ว\n', weight_array(end), volt_array(end));
            weight_array(end) = []; 
            volt_array(end) = [];
            current_step = max(1, current_step - 1); 
        else
            disp('⚠ ยังไม่มีข้อมูลในระบบให้ลบครับ');
        end
        
    elseif strcmp(cmd, 'C')
        weight_array = [];
        volt_array = [];
        current_step = 1;
        v_zero_offset = 0; % รีเซ็ตค่า Zero คืนค่าเดิมด้วย
        disp('🧹 ล้างค่าทั้งหมด (รวมถึงค่า Zero) เรียบร้อย โปรแกรมกลับไปเริ่มต้นใหม่');
        
    elseif strcmp(cmd, 'L')
        disp('🚪 กำลังออกจากโปรแกรมและจัดทำไฟล์รายงาน...');
        break; 
        
    else
        disp('❌ คำสั่งไม่ถูกต้อง! พิมพ์แค่ Z, J, K, C หรือ L');
    end
end

% =========================================================================
% 5. ส่งออกไฟล์ Excel (.xlsx) แบบระบุ Path และรันเลขไฟล์อัตโนมัติ
% =========================================================================
if ~isempty(weight_array)
    ResultTable = table(weight_array, volt_array, 'VariableNames', {'Weight_g', 'Adjusted_Voltage_V'});
    
    % 5.1 กำหนด Path ที่ต้องการเซฟไฟล์
    save_path = 'D:\kmutt\FRA271_RMX\LAB\Lab1.4\load cell';
    
    if ~exist(save_path, 'dir')
        mkdir(save_path);
    end
    
    % 5.2 ตั้งชื่อไฟล์หลักที่ต้องการ
    base_filename = 'Calibration_Result';
    ext = '.xlsx';
    filename = [base_filename, ext];
    full_filepath = fullfile(save_path, filename);
    
    % 5.3 เช็คไฟล์ซ้ำ (ถ้ามีไฟล์ชื่อนี้อยู่แล้ว ให้รันเลขต่อท้ายเป็น _1, _2, _3)
    counter = 1;
    while exist(full_filepath, 'file')
        filename = sprintf('%s_%d%s', base_filename, counter, ext);
        full_filepath = fullfile(save_path, filename);
        counter = counter + 1;
    end
    
    % 5.4 บันทึกไฟล์ Excel ตามชื่อที่ผ่านการเช็คแล้ว
    writetable(ResultTable, full_filepath); 
    fprintf('📁 บันทึกข้อมูลสำเร็จ! สามารถเข้าไปดูไฟล์ได้ที่:\n%s\n', full_filepath);
    
    figure('Name', 'Calibration Curve', 'NumberTitle', 'off');
    plot(weight_array, volt_array, '-ob', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
    title('Sensor Calibration Curve (Tare Applied)');
    xlabel('Weight (grams)');
    ylabel('Adjusted Voltage (V)');
    grid on;
    
    if length(weight_array) > 1
        p = polyfit(weight_array, volt_array, 1);
        eq_text = sprintf('สมการ Calibration: \n Voltage = (%.5f * Weight) + %.5f', p(1), p(2));
        text(min(weight_array), max(volt_array), eq_text, 'VerticalAlignment', 'top', 'FontSize', 10, 'Color', 'r', 'FontWeight', 'bold');
    else
        disp('⚠️ มีข้อมูลแค่ 1 จุด จึงไม่สามารถคำนวณหาสมการเส้นตรง (Calibration Equation) ได้ครับ');
    end
else
    disp('⚠️ ไม่มีข้อมูลถูกบันทึก จึงไม่มีการสร้างไฟล์และกราฟครับ');
end