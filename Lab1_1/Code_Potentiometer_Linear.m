% 1. โหลดโมเดล
model_name = 'sensorExpoler'; 
load_system(model_name);

% 2. ตรวจสอบและสร้างตัวแปร
if ~exist('History_Avg_Run', 'var')
    % ตัวแปรเก็บค่าเฉลี่ย
    History_Avg_Run = [];
    History_Avg_A1 = [];
    History_Avg_B1 = [];
    Run_Count = 0;
end

disp('--- โปรแกรมเก็บข้อมูล A1 และ B1 (ส่งออก CSV: ค่าเฉลี่ย 1 ไฟล์ + Raw Data แยกตามรอบ) ---');

% 3. เริ่มวนลูป
while true
    str = input('\nกด Enter รัน 10 วิ (พิมพ์ c เพื่อล้างค่า, พิมพ์ q เพื่อออก): ', 's');

    if strcmpi(str, 'q')
        clear History_Avg_Run History_Avg_A1 History_Avg_B1 Run_Count;
        disp('✅ ออกจากโปรแกรม และล้างค่าเรียบร้อย!');
        break; 

    elseif strcmpi(str, 'c')
        History_Avg_Run = []; History_Avg_A1 = []; History_Avg_B1 = [];
        Run_Count = 0;
        disp('🔄 ล้างข้อมูลเก่าออกหมดแล้ว! พร้อมนับรอบ 1 ใหม่');
        continue; 
    end

    Run_Count = Run_Count + 1;
    fprintf('\n⏳ กำลังรัน Simulink รอบที่ %d...\n', Run_Count);

    % สั่งรัน 10 วินาที
    out = sim(model_name, 'StopTime', '10');

    % --- จัดการ Raw Data ---
    % ดึงค่าจากกล่อง out_A1 และ out_B1 ใน Simulink
    time_sec = out.out_A1.Time;
    A1_data  = out.out_A1.Data;
    B1_data  = out.out_B1.Data;

    % --- จัดการ Average Data ---
    cur_mean_A1 = mean(A1_data);
    cur_mean_B1 = mean(B1_data);

    % สะสมค่าเฉลี่ย
    History_Avg_Run(end+1, 1) = Run_Count;
    History_Avg_A1(end+1, 1) = cur_mean_A1;
    History_Avg_B1(end+1, 1) = cur_mean_B1;

    fprintf(' 📊 ค่าเฉลี่ยรอบที่ %d -> A1: %.4f V | B1: %.4f V\n', ...
        Run_Count, cur_mean_A1, cur_mean_B1);

    % ===================================================
    % 4. บันทึกเป็นไฟล์ CSV (แยกตามรอบ)
    % ===================================================

    % 4.1 ไฟล์ที่ 1: ตารางค่าเฉลี่ย (อัปเดตไฟล์เดิม)
    T_avg = table(History_Avg_Run, History_Avg_A1, History_Avg_B1, ...
        'VariableNames', {'Run_Number', 'Avg_Voltage_A1', 'Avg_Voltage_B1'});
    writetable(T_avg, 'Potentiometer_Average_Linear.csv');

    % 4.2 ไฟล์ที่ 2, 3, 4... : ตารางข้อมูลดิบ (สร้างไฟล์ใหม่รายรอบ)
    T_raw_current = table(time_sec, A1_data, B1_data, ...
        'VariableNames', {'Time_sec', 'Voltage_A1', 'Voltage_B1'});

    % ตั้งชื่อไฟล์ให้ตรงกับหมายเลขรอบ เช่น Potentiometer_RawData_Run1.csv
    filename_raw = sprintf('Potentiometer_RawData_Linear_Run%d.csv', Run_Count);
    writetable(T_raw_current, filename_raw);

    fprintf('✅ อัปเดตไฟล์สำเร็จ! (ได้ไฟล์ %s)\n', filename_raw);
end