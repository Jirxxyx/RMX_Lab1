% =========================================================================
% LAB 1.4: Single Point Load Cell with INA125 Data Plotting Script
% =========================================================================

% 1. อ่านข้อมูลจากไฟล์ CSV
data = readtable('Lab1.4.csv');

% 2. กำหนดค่าพารามิเตอร์และดึงข้อมูลจากตาราง

V_Q = -0.14725 ;
m = 0.33177;

Weight = (data.Weight_g)/1000;

Avg_1 = data.Adjusted_Voltage_V_1 ;
Avg_2 = data.Adjusted_Voltage_V_2 ;
Avg_3 = data.Adjusted_Voltage_V_3 ;
Avg = data.Adjusted_Voltage_V_AVERAGE ;

% =========================================================================
% กราฟเปรียบเทียบ Weight กับ แรงดันไฟฟ้า
% =========================================================================

fig1 = figure(1);
set(fig1, 'Name', 'Weight & Voltage', 'NumberTitle', 'off');

plot(Weight, Avg_1,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 1');
hold on;
plot(Weight, Avg_2, '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 2');
plot(Weight, Avg_3,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 3');
plot(Weight, Avg, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Average Voltage');
hold off;

title('กราฟแสดงความสัมพันธ์ระหว่างน้ำหนัก (Weight) และแรงดันไฟฟ้า (Voltage)');
ylabel('Weight (kg)');
xlabel('Voltage (V)');
legend('Location', 'best');
grid on;

% =========================================================================
% กราฟเปรียบเทียบ Weight_calculated กับ แรงดันไฟฟ้า
% =========================================================================

fig2 = figure(2);
set(fig2, 'Name', 'Weight_calculated & Voltage', 'NumberTitle', 'off');

plot(Avg, (Avg-V_Q)/m, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Average Voltage');
hold on;
hold off;

title('กราฟแสดงความสัมพันธ์ระหว่างน้ำหนักคำนวณ (Weight calculated) และแรงดันไฟฟ้า (Voltage)');
xlabel('Voltage (V)');
ylabel('Weight (kg)');
legend('Location', 'best');
grid on;