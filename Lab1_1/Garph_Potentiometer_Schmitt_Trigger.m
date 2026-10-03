 % 1. อ่านข้อมูลจากไฟล์ CSV
data = readtable('Avg_Voltage.csv');

% 2. กำหนดแกน X และแกน Y จากหัวคอลัมน์ในตาราง
% ใช้ Run_Number เป็นแกน X (Rotation)
time = data.Var18;

% ดึงค่าเฉลี่ยของแต่ละช่องมาเป็นแกน Y

input_Voltage = data.Var19;
output_Voltage = data.Var20;
Threshold_High = 2;
Threshold_Low = 1;

% 3. สร้างหน้าต่างกราฟ
figure;

% 4. พล็อตกราฟเส้น

plot(time, input_Voltage, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
hold on;
plot(time, output_Voltage, '-', 'LineWidth', 1.5, 'MarkerSize', 6);

yline(Threshold_High, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Threshold_High');
yline(Threshold_Low, 'b--', 'LineWidth', 1.5, 'DisplayName', 'Threshold_Low');

% 5. ตกแต่งกราฟให้สวยงามและอ่านง่าย
title('กราฟแสดงความสัมพันธ์ระหว่างแรงดัน Input (Voltage) และสัญญาณ Output (Schmitt Trigger)');
xlabel('Time (s)');
ylabel('Voltage (V)');

% ใส่คำอธิบายเส้นกราฟ
legend('Voltage (V)', 'Schmitt Trigger', 'Threshold_High', 'Threshold_Low', 'Location', 'best');

% เปิดตารางกริด
grid on;
hold off;