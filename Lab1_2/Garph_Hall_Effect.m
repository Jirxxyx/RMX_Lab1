% =========================================================================
% LAB 1.3: Magnetic Sensor Data Plotting Script
% =========================================================================

% 1. อ่านข้อมูลจากไฟล์ CSV
data = readtable('Avg_Hall_Effot.csv');

% 2. กำหนดค่าพารามิเตอร์และดึงข้อมูลจากตาราง
V_Q = 2500;         % Quiescent Voltage (mV) สำหรับ Vcc = 5V (หรือเปลี่ยนเป็น 1650 หากใช้ Vcc = 3.3V)
Sensitivity = 12.5; % Sensitivity (mV/mT)

distance = data.distance;

% ค่าเฉลี่ยแรงดันไฟฟ้า (Voltage Average: mV)

% North - Shield %
Avg_NS_1 = data.Avg_NS_1 ;
Avg_NS_2 = data.Avg_NS_2 ;
Avg_NS_3 = data.Avg_NS_3 ;
Avg_NS = data.Avg_NS ;
% North - Shield %

% North - No Shield %
Avg_N_1 = data.Avg_N_1 ;
Avg_N_2 = data.Avg_N_2 ;
Avg_N_3 = data.Avg_N_3 ;
Avg_N = data.Avg_N ;
% North - No Shield %

% South - Shield %
Avg_SS_1 = data.Avg_SS_1 ;
Avg_SS_2 = data.Avg_SS_2 ;
Avg_SS_3 = data.Avg_SS_3 ;
Avg_SS = data.Avg_SS ;
% South - Shield %

% South - No Shield %
Avg_S_1 = data.Avg_S_1 ;
Avg_S_2 = data.Avg_S_2 ;
Avg_S_3 = data.Avg_S_3 ;
Avg_S = data.Avg_S ;
% South - No Shield %

% คำนวณค่าความหนาแน่นสนามแม่เหล็ก (Magnetic Flux Density: B ในหน่วย mT)

% North - Shield %
B_NS_1 = ( Avg_NS_1 - V_Q ) / Sensitivity ;
B_NS_2 = ( Avg_NS_2 - V_Q ) / Sensitivity ;
B_NS_3 = ( Avg_NS_3 - V_Q ) / Sensitivity ;
B_NS = ( Avg_NS - V_Q ) / Sensitivity ;
% North - Shield %

% North - No Shield %
B_N_1 = ( Avg_N_1 - V_Q ) / Sensitivity ;
B_N_2 = ( Avg_N_2 - V_Q ) / Sensitivity ;
B_N_3 = ( Avg_N_3 - V_Q ) / Sensitivity ;
B_N = ( Avg_N - V_Q ) / Sensitivity ;
% North - No Shield %

% South - Shield %
B_SS_1 = ( Avg_SS_1 - V_Q ) / Sensitivity ;
B_SS_2 = ( Avg_SS_2 - V_Q ) / Sensitivity ;
B_SS_3 = ( Avg_SS_3 - V_Q ) / Sensitivity ;
B_SS = ( Avg_SS - V_Q ) / Sensitivity ;
% South - Shield %

% South - No Shield %
B_S_1 = ( Avg_S_1 - V_Q ) / Sensitivity ;
B_S_2 = ( Avg_S_2 - V_Q ) / Sensitivity ;
B_S_3 = ( Avg_S_3 - V_Q ) / Sensitivity ;
B_S = ( Avg_S - V_Q ) / Sensitivity ;
% South - No Shield %

% =========================================================================
% รูปที่ 1: กราฟเปรียบเทียบ Average North - Shield
% =========================================================================

fig1 = figure(1);
set(fig1, 'Name', 'Average North - Shield', 'NumberTitle', 'off');

plot(distance, Avg_NS_1,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 1');
hold on;
plot(distance, Avg_NS_2, '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 2');
plot(distance, Avg_NS_3,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 3');
plot(distance, Avg_NS, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Average North - Shield');
hold off;

title('กราฟแสดงความสัมพันธ์ระหว่างระยะทาง (Distance) และแรงดันไฟฟ้า (Voltage)');
xlabel('Distance (cm)');
ylabel('Voltage (mV)');
legend('Location', 'best');
grid on;

% =========================================================================
% รูปที่ 2: กราฟเปรียบเทียบ Average North - No Shield
% =========================================================================

fig2 = figure(2);
set(fig2, 'Name', 'Average North - No Shield', 'NumberTitle', 'off');

plot(distance, Avg_N_1,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 1');
hold on;
plot(distance, Avg_N_2, '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 2');
plot(distance, Avg_N_3,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 3');
plot(distance, Avg_N, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Average North - No Shield');
hold off;

title('กราฟแสดงความสัมพันธ์ระหว่างระยะทาง (Distance) และแรงดันไฟฟ้า (Voltage)');
xlabel('Distance (cm)');
ylabel('Voltage (mV)');
legend('Location', 'best');
grid on;

% =========================================================================
% รูปที่ 3: กราฟเปรียบเทียบ Average South - Shield
% =========================================================================

fig3 = figure(3);
set(fig3, 'Name', 'Average South - Shield', 'NumberTitle', 'off');

plot(distance, Avg_SS_1,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 1');
hold on;
plot(distance, Avg_SS_2, '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 2');
plot(distance, Avg_SS_3,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 3');
plot(distance, Avg_SS, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Average South - Shield');
hold off;

title('กราฟแสดงความสัมพันธ์ระหว่างระยะทาง (Distance) และแรงดันไฟฟ้า (Voltage)');
xlabel('Distance (cm)');
ylabel('Voltage (mV)');
legend('Location', 'best');
grid on;

% =========================================================================
% รูปที่ 4: กราฟเปรียบเทียบ Average South - No Shield
% =========================================================================

fig4 = figure(4);
set(fig4, 'Name', 'Average South - No Shield', 'NumberTitle', 'off');

plot(distance, Avg_S_1,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 1');
hold on;
plot(distance, Avg_S_2, '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 2');
plot(distance, Avg_S_3,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 3');
plot(distance, Avg_S, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Average South - No Shield');
hold off;

title('กราฟแสดงความสัมพันธ์ระหว่างระยะทาง (Distance) และแรงดันไฟฟ้า (Voltage)');
xlabel('Distance (cm)');
ylabel('Voltage (mV)');
legend('Location', 'best');
grid on;

% =========================================================================
% รูปที่ 5: กราฟเปรียบเทียบ Voltage vs Distance (ดูผลกระทบของ Shielding)
% =========================================================================
fig5 = figure(5);
set(fig5, 'Name', 'Distance vs Voltage', 'NumberTitle', 'off');

plot(distance, Avg_N,  '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'North - No Shield');
hold on;
plot(distance, Avg_NS, '--s', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'North - Shield');
plot(distance, Avg_S,  '-^', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'South - No Shield');
plot(distance, Avg_SS, '--v', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'South - Shield');
hold off;

title('กราฟแสดงความสัมพันธ์ระหว่างระยะทาง (Distance) และแรงดันไฟฟ้า (Voltage)');
xlabel('Distance (cm)');
ylabel('Voltage (mV)');
legend('Location', 'best');
grid on;

% =========================================================================
% รูปที่ 6: กราฟเปรียบเทียบ B North - Shield
% =========================================================================

fig6 = figure(6);
set(fig6, 'Name', 'B North - Shield', 'NumberTitle', 'off');

plot(distance, Avg_NS_1,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 1');
hold on;
plot(distance, Avg_NS_2, '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 2');
plot(distance, Avg_NS_3,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 3');
plot(distance, Avg_NS, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'B North - Shield');
hold off;

title('กราฟแสดงความสัมพันธ์ระหว่างระยะทาง (Distance) และความหนาแน่นสนามแม่เหล็ก (B)');
xlabel('Distance (cm)');
ylabel('Magnetic Field Density (mT)');
legend('Location', 'best');
grid on;

% =========================================================================
% รูปที่ 7: กราฟเปรียบเทียบ B North - No Shield
% =========================================================================

fig7 = figure(7);
set(fig7, 'Name', 'B North - No Shield', 'NumberTitle', 'off');

plot(distance, B_N_1,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 1');
hold on;
plot(distance, B_N_2, '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 2');
plot(distance, B_N_3,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 3');
plot(distance, B_N, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'B North - No Shield');
hold off;

title('กราฟแสดงความสัมพันธ์ระหว่างระยะทาง (Distance) และความหนาแน่นสนามแม่เหล็ก (B)');
xlabel('Distance (cm)');
ylabel('Magnetic Field Density (mT)');
legend('Location', 'best');
grid on;

% =========================================================================
% รูปที่ 8: กราฟเปรียบเทียบ B South - Shield
% =========================================================================

fig8 = figure(8);
set(fig8, 'Name', 'B South - Shield', 'NumberTitle', 'off');

plot(distance, B_SS_1,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 1');
hold on;
plot(distance, B_SS_2, '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 2');
plot(distance, B_SS_3,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 3');
plot(distance, B_SS, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'B South - Shield');
hold off;

title('กราฟแสดงความสัมพันธ์ระหว่างระยะทาง (Distance) และความหนาแน่นสนามแม่เหล็ก (B)');
xlabel('Distance (cm)');
ylabel('Magnetic Field Density (mT)');
legend('Location', 'best');
grid on;

% =========================================================================
% รูปที่ 9: กราฟเปรียบเทียบ B South - No Shield
% =========================================================================

fig9 = figure(9);
set(fig9, 'Name', 'B South - No Shield', 'NumberTitle', 'off');

plot(distance, B_S_1,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 1');
hold on;
plot(distance, B_S_2, '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 2');
plot(distance, B_S_3,  '-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Trial 3');
plot(distance, B_S, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'B South - No Shield');
hold off;

title('กราฟแสดงความสัมพันธ์ระหว่างระยะทาง (Distance) และความหนาแน่นสนามแม่เหล็ก (B)');
xlabel('Distance (cm)');
ylabel('Magnetic Field Density (mT)');
legend('Location', 'best');
grid on;

% =========================================================================
% รูปที่ 10: กราฟเปรียบเทียบ Magnetic Flux Density (B) vs Distance
% =========================================================================
fig10 = figure(10);
set(fig10, 'Name', 'Magnetic Flux Density (B) vs Distance', 'NumberTitle', 'off');

plot(distance, B_N,  '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'North - No Shield');
hold on;
plot(distance, B_NS, '--s', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'North - Shield');
plot(distance, B_S,  '-^', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'South - No Shield');
plot(distance, B_SS, '--v', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'South - Shield');
hold off;

title('กราฟแสดงความสัมพันธ์ระหว่างระยะทาง (Distance) และความหนาแน่นสนามแม่เหล็ก (B)');
xlabel('Distance (cm)');
ylabel('Magnetic Field Density (mT)');
legend('Location', 'best');
grid on;

% =========================================================================
% รูปที่ 11: กราฟคุณลักษณะความเป็นเชิงเส้น North Pole (Linearity Curve: Voltage vs B)
% =========================================================================
fig11 = figure(11);
set(fig11, 'Name', 'Voltage vs B (North Pole)', 'NumberTitle', 'off');

plot(B_N, Avg_N, 'bo-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'North Pole (No Shield)');
hold on;
plot(B_NS, Avg_NS, 'ro-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'North Pole (Shield)');
hold off;

title('กราฟแสดงคุณลักษณะความเป็นเชิงเส้นของเซ็นเซอร์ (Sensor Linearity)');
xlabel('Magnetic Field Density (mT)');
ylabel('Voltage (mV)');
legend('Location', 'northwest');
grid on;

% =========================================================================
% รูปที่ 12: กราฟคุณลักษณะความเป็นเชิงเส้น South Pole (Linearity Curve: Voltage vs B)
% =========================================================================
fig12 = figure(12);
set(fig12, 'Name', 'Voltage vs B (South Pole)', 'NumberTitle', 'off');

plot(B_S, Avg_S, 'bo-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'South Pole (No Shield)');
hold on;
plot(B_SS, Avg_SS, 'ro-', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'South Pole (Shield)');
hold off;

title('กราฟแสดงคุณลักษณะความเป็นเชิงเส้นของเซ็นเซอร์ (Sensor Linearity)');
xlabel('Magnetic Field Density (mT)');
ylabel('Voltage (mV)');
legend('Location', 'northwest');
grid on;