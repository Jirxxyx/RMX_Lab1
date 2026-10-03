% 1. โหลดโมเดล
model_name = 'sensorExpoler'; 
load_system(model_name);

% 2. ตรวจสอบและสร้างตัวแปร
if ~exist('History_Avg_Run', 'var')
    % ตัวแปรเก็บค่าเฉลี่ย
    History_Avg_Run = [];
    History_Avg_A = [];
    History_Avg_B = [];
    History_Avg_C = [];
    Run_Count = 0;
end

disp('--- โปรแกรมเก็บข้อมูล (ส่งออก CSV: ค่าเฉลี่ย 1 ไฟล์ + Raw Data แยกไฟล์ตามรอบ) ---');

% 3. เริ่มวนลูป
while true
    str = input('\nกด Enter รัน 10 วิ (พิมพ์ c เพื่อล้างค่า, พิมพ์ q เพื่อออก): ', 's');
    
    if strcmpi(str, 'q')
        clear History_Avg_Run History_Avg_A History_Avg_B History_Avg_C Run_Count;
        disp('✅ ออกจากโปรแกรม และล้างค่าเรียบร้อย!');
        break; 
        
    elseif strcmpi(str, 'c')
        History_Avg_Run = []; History_Avg_A = []; History_Avg_B = []; History_Avg_C = [];
        Run_Count = 0;
        disp('🔄 ล้างข้อมูลเก่าออกหมดแล้ว! พร้อมนับรอบ 1 ใหม่');
        continue; 
    end
    
    Run_Count = Run_Count + 1;
    fprintf('\n⏳ กำลังรัน Simulink รอบที่ %d...\n', Run_Count);
    
    % สั่งรัน 10 วินาที
    out = sim(model_name, 'StopTime', '10');
    
    % --- จัดการ Raw Data ---
    time_sec = out.out_A.Time;
    v1_data  = out.out_A.Data;
    v2_data  = out.out_B.Data;
    v3_data  = out.out_C.Data;
    
    % --- จัดการ Average Data ---
    cur_mean_A = mean(v1_data);
    cur_mean_B = mean(v2_data);
    cur_mean_C = mean(v3_data);
    
    % สะสมค่าเฉลี่ย
    History_Avg_Run(end+1, 1) = Run_Count;
    History_Avg_A(end+1, 1) = cur_mean_A;
    History_Avg_B(end+1, 1) = cur_mean_B;
    History_Avg_C(end+1, 1) = cur_mean_C;
    
    fprintf(' 📊 ค่าเฉลี่ยรอบที่ %d -> A: %.4f V | B: %.4f V | C: %.4f V\n', ...
            Run_Count, cur_mean_A, cur_mean_B, cur_mean_C);
            
    % ===================================================
    % 4. บันทึกเป็นไฟล์ CSV (แยกตามรอบ)
    % ===================================================
    
    % 4.1 ไฟล์ที่ 1: ตารางค่าเฉลี่ย (อัพ% ปเดตไฟล์เดิม)
    T_avg = table(History_Avg_Run, History_Avg_A, History_Avg_B, History_Avg_C, ...
        'VariableNames', {'Run_Number', 'Avg_Voltage_A', 'Avg_Voltage_B', 'Avg_Voltage_C'});
    writetable(T_avg, 'Potentiometer_Average_Rotary.csv');
        
    % 4.2 ไฟล์ที่ 2, 3, 4... : ตารางข้อมูลดิบ (สร้างไฟล์ใหม่รายรอบ)
    T_raw_current = table(time_sec, v1_data, v2_data, v3_data, ...
        'VariableNames', {'Time_sec', 'Voltage_A', 'Voltage_B', 'Voltage_C'});
        
    % ตั้งชื่อไฟล์ให้ตรงกับหมายเลขรอบ เช่น Potentiometer_RawData_Run1.csv
    filename_raw = sprintf('Potentiometer_RawData_Rotary_Run%d.csv', Run_Count);
    writetable(T_raw_current, filename_raw);
    
    fprintf('✅ อัปเดตไฟล์สำเร็จ! (ได้ไฟล์ %s)\n', filename_raw);
end