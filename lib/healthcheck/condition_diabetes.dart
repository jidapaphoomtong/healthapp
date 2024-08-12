String determineCondition(int fpg) {
if (fpg > 126) {
return 'มีความเสี่ยงเป็นโรคเบาหวาน';
} else if (fpg >= 100 && fpg <= 125) {
return 'มีภาวะเสี่ยงหรือเบาหวานแฝง';
} else if ((fpg >= 70 && fpg <= 100)) {
return 'ภาวะปกติ';
} else {
return 'ไม่สามารถประมวลผลได้';
}
}