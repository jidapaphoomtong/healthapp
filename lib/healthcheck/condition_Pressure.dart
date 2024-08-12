String determineCondition(int sys, int dia, int pul) {
if (sys > 180 || dia > 110) {
return 'ความดันโลหิตสูงมาก';
} else if (sys >= 160 && sys <= 179 || dia >= 100 && dia <= 109) {
return 'ความดันโลหิตสูงปานกลาง';
} else if ((sys >= 140 && sys <= 159) || (dia >= 90 && dia <= 99)) {
return 'ความดันโลหิตสูงเล็กน้อย';
} else if ((sys >= 130 && sys <= 139) || (dia >= 85 && dia <= 89)) {
return 'ความดันโลหิตค่อนข้างสูง';
} else if (sys >= 120 && sys <= 129 || dia >= 80 && dia <= 84) {
return 'ความดันโลหิตปกติ';
} else {
return 'ไม่สามารถประมวลผลได้';
}
}
