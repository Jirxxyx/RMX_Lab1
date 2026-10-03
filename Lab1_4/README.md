
## Lab 1.4: Single Point Load Cell with INA125 Instrumentation Amplifier

## 📁 โครงสร้างไฟล์ในโฟลเดอร์ (File Directory)

| `Simulink_Lab1.4.slx` | Simulink Model | แบบจำลองรับสัญญาณอนาล็อกจากวงจรขยาย INA125 เข้าบอร์ด STM32/ADC |

| `Code_Load_Cell_with_INA125.m` | MATLAB Script | โค้ดประมวลผลข้อมูล แปลงค่า ADC เป็นแรงดัน $V_{out}$ และคำนวณการปรับเทียบน้ำหนัก (Linear Regression) |

| `Garph_Load_Cell_with_INA125.m` | MATLAB Script | สคริปต์พล็อกราฟความสัมพันธ์ระหว่างน้ำหนักจริงเทียบกับแรงดันเอาต์พุต และกราฟวิเคราะห์ % Error |
