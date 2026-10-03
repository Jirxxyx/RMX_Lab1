
% เคลียร์กราฟเก่า
close all; clc;
try
    % 1. ใช้แกนเวลาของ X4 (Angular Position) เป็น "แกนเวลามาตรฐาน" (Master Time)
    % (เพราะเรารู้ว่ากราฟ 1-3 เวลามันวิ่งถึง 10 วิ ปกติ)
    t_master = out.pos_x4.Time(:);
    
    % ดึงข้อมูล Raw (ดิบ)
    raw_x4 = safe_align(out.raw_x4, t_master);
    raw_x2 = safe_align(out.raw_x2, t_master);
    raw_x1 = safe_align(out.raw_x1, t_master);
    
    % ดึงข้อมูล Total Position (Pulses)
    tot_x4 = safe_align(out.total_pos_x4, t_master);
    tot_x2 = safe_align(out.total_pos_x2, t_master);
    tot_x1 = safe_align(out.total_pos_x1, t_master);
    
    % ดึงข้อมูล Angular Position (Radians)
    pos_x4 = safe_align(out.pos_x4, t_master);
    pos_x2 = safe_align(out.pos_x2, t_master);
    pos_x1 = safe_align(out.pos_x1, t_master);
    
    % ดึงข้อมูล Angular Velocity (rad/s)
    vel_x4 = safe_align(out.vel_x4, t_master);
    vel_x2 = safe_align(out.vel_x2, t_master);
    vel_x1 = safe_align(out.vel_x1, t_master);
    
    disp('จัดรูปแบบข้อมูลและปรับเวลาให้เท่ากันสำเร็จ! กำลังสร้างกราฟ...');
    
catch ME
    error('หาตัวแปรไม่เจอครับ! อาการคือ: %s', ME.message);
end
% --- ทำ Moving Average Filter ฝั่งซอฟต์แวร์ ---
% ตัวเลข 50 คือ Window Size ลองปรับเพิ่มลดได้เพื่อให้กราฟโค้งสวยตามต้องการ
window_size = 50; 
vel_x4 = smoothdata(vel_x4, 'movmean', window_size);
vel_x2 = smoothdata(vel_x2, 'movmean', window_size);
vel_x1 = smoothdata(vel_x1, 'movmean', window_size);

% --- สร้างกราฟ 4 ชั้น พร้อมระบุชื่อแกนและหน่วยครบถ้วน ---
fig = figure('Name', 'Lab 1.3 Full Analysis', 'Position', [100, 50, 900, 850]);

% --- กราฟที่ 1: Raw Counts ---
subplot(4, 1, 1);
plot(t_master, raw_x4, 'b', 'LineWidth', 1.2); hold on;
plot(t_master, raw_x2, 'r--', 'LineWidth', 1.2);
plot(t_master, raw_x1, 'g:', 'LineWidth', 1.2);
title('1. Raw Counts (ฮาร์ดแวร์ดิบ)', 'FontWeight', 'bold');
xlabel('Time [s]'); ylabel('Raw Counts [Counts]');
legend('X4', 'X2', 'X1', 'Location', 'best');
xlim([0 max(t_master)]); % บังคับให้แกน X สุดที่ 10 วิเท่ากัน
grid on; grid minor;

% --- กราฟที่ 2: Total Position (Relative Position) ---
subplot(4, 1, 2);
plot(t_master, tot_x4, 'b', 'LineWidth', 1.2); hold on;
plot(t_master, tot_x2, 'r--', 'LineWidth', 1.2);
plot(t_master, tot_x1, 'g:', 'LineWidth', 1.2);
title('2. Total Position (Pulses - หลังผ่าน WrapAround)', 'FontWeight', 'bold');
xlabel('Time [s]'); ylabel('Relative Position [Pulses]');
legend('X4', 'X2', 'X1', 'Location', 'best');
xlim([0 max(t_master)]);
grid on; grid minor;

% --- กราฟที่ 3: Angular Position ---
subplot(4, 1, 3);
plot(t_master, pos_x4, 'b', 'LineWidth', 1.2); hold on;
plot(t_master, pos_x2, 'r--', 'LineWidth', 1.2);
plot(t_master, pos_x1, 'g:', 'LineWidth', 1.2);
title('3. Angular Position (Radians)', 'FontWeight', 'bold');
xlabel('Time [s]'); ylabel('Position (\theta) [rad]');
legend('X4', 'X2', 'X1', 'Location', 'best');
xlim([0 max(t_master)]);
grid on; grid minor;

% --- กราฟที่ 4: Angular Velocity ---
subplot(4, 1, 4);
plot(t_master, vel_x4, 'b', 'LineWidth', 1.2); hold on;
plot(t_master, vel_x2, 'r--', 'LineWidth', 1.2);
plot(t_master, vel_x1, 'g:', 'LineWidth', 1.2);
title('4. Angular Velocity (rad/s - หลังผ่าน Filter)', 'FontWeight', 'bold');
xlabel('Time [s]'); ylabel('Velocity (\omega) [rad/s]');
legend('X4', 'X2', 'X1', 'Location', 'best');
xlim([0 max(t_master)]);
grid on; grid minor;

% =========================================================================
% ฟังก์ชันผู้ช่วยสำหรับบังคับข้อมูลให้เข้ากับแกนเวลา Master (แก้ไขขั้นเด็ดขาด)
% =========================================================================
function val_out = safe_align(ts_obj, t_ref)
    % 1. ดึงแกนเวลาและข้อมูลดิบ
    t_raw = ts_obj.Time(:);
    rawData = ts_obj.Data;
    
    % 2. แกะกล่องข้อมูล (Unbox Cell Array)
    if iscell(rawData)
        val_raw = double(cell2mat(rawData(:)));
    else
        val_raw = double(rawData(:));
    end
    
    % *** 3. ไม้ตาย: หั่น Time กับ Data ให้มีความยาวเท่ากันก่อนเสมอ ***
    % (ป้องกันบั๊ก Simulink ส่งข้อมูลกับเวลามาไม่เท่ากัน)
    min_len = min(length(t_raw), length(val_raw));
    t_raw = t_raw(1:min_len);
    val_raw = val_raw(1:min_len);
    
    % 4. เข้าสู่กระบวนการจัดแกนเวลาให้เท่ากับ 10 วิ
    if length(val_raw) == length(t_ref)
        val_out = val_raw;
    else
        [t_uniq, idx] = unique(t_raw); % ตัดจุดเวลาที่ซ้ำกันออก
        val_uniq = val_raw(idx);
        % ยืดข้อมูลให้พอดีกับแกนเวลา Master
        val_out = interp1(t_uniq, val_uniq, t_ref, 'linear', 'extrap');
    end
end