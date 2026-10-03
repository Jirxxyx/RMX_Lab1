% 1. อ่านข้อมูลจากไฟล์ CSV
data = readtable('Avg_Voltage.csv');

% 2. กำหนดแกน X และแกน Y จากหัวคอลัมน์ในตาราง
% ใช้ Run_Number เป็นแกน X (Rotation)
rotation = data.Var2;

% ดึงค่าเฉลี่ยของแต่ละช่องมาเป็นแกน Y

avg_A1 = data.Var3;
avg_A2 = data.Var4;
avg_A3 = data.Var5;
Avg_A = data.Var6;

avg_B1 = data.Var8;
avg_B2 = data.Var9;
avg_B3 = data.Var10;
Avg_B = data.Var11;

avg_C1 = data.Var13;
avg_C2 = data.Var14;
avg_C3 = data.Var15;
Avg_C = data.Var16;

input_Voltage = 3.3;

% 3. สร้างหน้าต่างกราฟ
figure;

% 4. พล็อตกราฟเส้น

% plot(rotation, (avg_A1/input_Voltage) * 100, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
% hold on;
% plot(rotation, (avg_A2/input_Voltage) * 100, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
% plot(rotation, (avg_A3/input_Voltage) * 100, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
% plot(rotation, (Avg_A/input_Voltage) * 100, '-', 'LineWidth', 1.5, 'MarkerSize', 6);

% plot(rotation, (avg_B1/input_Voltage) * 100, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
% hold on;
% plot(rotation, (avg_B2/input_Voltage) * 100, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
% plot(rotation, (avg_B3/input_Voltage) * 100, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
% plot(rotation, (Avg_B/input_Voltage) * 100, '-', 'LineWidth', 1.5, 'MarkerSize', 6);

plot(rotation, (1 - (avg_C1 / input_Voltage)) * 100, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
hold on;
plot(rotation, (1 - (avg_C2 / input_Voltage)) * 100, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
plot(rotation, (1 - (avg_C3 / input_Voltage)) * 100, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
plot(rotation, (1 - (Avg_C / input_Voltage)) * 100, '-', 'LineWidth', 1.5, 'MarkerSize', 6);

% 5. ตกแต่งกราฟให้สวยงามและอ่านง่าย
title(sprintf('กราฟแสดงความสัมพันธ์ระหว่างระยะการหมุน (Rotational Travel) และอัตราส่วนแรงดัน (Output Voltage Ratio)\nของ Rotary Potentiometer Type C'));
xlabel('Rotational Travel (%)');
ylabel('Output Voltage Ratio (%)');

% ใส่คำอธิบายเส้นกราฟ
% legend('Trial 1', 'Trial 2', 'Trial 3', 'Average Output Voltage Ratio A', 'Location', 'best');
% legend('Trial 1', 'Trial 2', 'Trial 3', 'Average Output Voltage Ratio B', 'Location', 'best');
legend('Trial 1', 'Trial 2', 'Trial 3', 'Average Output Voltage Ratio C', 'Location', 'best');

% เปิดตารางกริด
grid on;
hold off;