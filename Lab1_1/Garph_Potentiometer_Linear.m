% 1. อ่านข้อมูลจากไฟล์ CSV
data = readtable('Avg_Voltage.csv');

% 2. กำหนดแกน X และแกน Y จากหัวคอลัมน์ในตาราง
% ใช้ Run_Number เป็นแกน X (Rotation)
distance = data.Var23;

% ดึงค่าเฉลี่ยของแต่ละช่องมาเป็นแกน Y

avg_A1_1 = data.Var24;
avg_A1_2 = data.Var25;
Avg_A1 = data.Var26;

avg_B1_1 = data.Var28;
avg_B1_2 = data.Var29;
Avg_B1 = data.Var30;

% 3. สร้างหน้าต่างกราฟ
figure;

% 4. พล็อตกราฟเส้น

plot(distance, avg_A1_1, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
hold on;
plot(distance, avg_A1_2, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
plot(distance, Avg_A1, '-', 'LineWidth', 1.5, 'MarkerSize', 6);

% plot(distance, avg_B1_1, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
% hold on;
% plot(distance, avg_B1_2, '-', 'LineWidth', 1.5, 'MarkerSize', 6);
% plot(distance, Avg_B1, '-', 'LineWidth', 1.5, 'MarkerSize', 6);

% 5. ตกแต่งกราฟให้สวยงามและอ่านง่าย
title(sprintf('กราฟแสดงความสัมพันธ์ระหว่างระยะห่างการเลื่อน (Distance) และค่าเฉลี่ยแรงดันไฟฟ้า (Voltage Avg.)\nของ Linear Potentiometer Type A'));
xlabel('Distance (cm)');
ylabel('Voltage Avg. (V)');

% ใส่คำอธิบายเส้นกราฟ
legend('Trial 1', 'Trial 2', 'Average Voltage A', 'Location', 'best');
% legend('Trial 1', 'Trial 2', 'Average Voltage B', 'Location', 'best');

% เปิดตารางกริด
grid on;
hold off;