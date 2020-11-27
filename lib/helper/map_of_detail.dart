const Map<String, String> diagnosisHeader = {
  'อุณหภูมิร่างกาย': 'รายละเอียด',
  'เหงื่อออก': 'รายละเอียด',
  'อาการปวดหัว': 'รายละเอียด',
  'การนอนหลับ': 'รายละเอียด',
  'การขับถ่าย': 'รายละเอียด',
  'อาการชา': 'รายละเอียด',
};

const Map<String, String> diagnosisButtonLabel = {
  'อุณหภูมิร่างกาย': 'ปกติ',
  'เหงื่อออก': 'ไม่มีอาการ',
  'อาการปวดหัว': 'ไม่มีอาการ',
  'การนอนหลับ': 'ปกติ',
  'การขับถ่าย': 'ปกติ',
  'อาการชา': 'ไม่มีอาการ',
};

const Map<String, String> diagnosisDetails = {
  'อุณหภูมิร่างกาย': 'เช่น อุณหภูมิร่างกาย ระยะเวลาการเป็นไข้',
  'เหงื่อออก': 'เช่น เหงื่ออกช่วงเวลาใด บริเวณใด',
  'อาการปวดหัว': 'เช่น บริเวณที่ปวด อาหารผิดปกติที่ได้รับประทานเข้าไป',
  'การนอนหลับ': 'เช่น ตื่นกี่ครั้งระหว่างนอน นอนกี่ชั่วโมงต่อวัน',
  'การขับถ่าย': 'เช่น ท้องอืด ท้องเสีย แน่นท้อง',
  'อาการชา': 'บริเวณที่มีอาการชา เกิดอาการชาเวลาใด',
};

const Map<String, String> credentialTranslator = {
  'fullName': 'ชื่อ-นามสกุล',
  'address': 'ที่อยู่',
};

const List<String> diagnosticSendingSteps = [
  'กดปุ่มบวกที่มุมบนขวาของหน้าจอหลัก',
  'กรอกรายละเอียดให้ครบถ้วน',
  'เพิ่มรูปภาพลิ้นของผู้ที่ต้องการจะวิเคราะห์ รูปควรใกล้เคียงกับสีจริง และมีความละเอียดรูปภาพปานกลาง-สูง',
  'หลังจากกรอกข้อมูลครบถ้วนให้กดส่ง จากนั้นแพทย์จะทำการวิเคราะห์ให้ภายใน 48 ชั่วโมง',
  'ทำการโอนเงินตามจำนวนเงินที่ได้ระบุไว้ เพื่อเป็นค่ายา และค่าจัดส่ง ไปยังบัญชีที่ขึ้นมา',
  'แนบหลักฐานการโอนเงิน',
  'หลังจากที่ได้ตรวจสอบหลักฐานการโอนเงินแล้ว ข้อความจะเป็นสีเขียน และทางคลินิกจะทำการจัดส่งยาไปยังที่อยู่ที่ได้ลงทะเบียนไว้',
  'การจัดส่งอาจใช้เวลานานถึง 1 สัปดาห์',
  'หลังจากที่ได้รับประทานยาแล้วสามารถเขียนอาการ หรือผลลัพธ์เพื่อใช้ในการวินิฉัยครั้งถัดไป',
];

const Map<String, String> contactData = {
  'FB': 'ฮ้วอุยตึ๊ง คลินิกการแพทย์แผนจีน',
  'LINE': '@huayitang',
  'phone': '02-004-5202',
  'address': '118 จันทร์18/7 แยก17 แขวงทุ่งวัดดอน\nเขตสาทร กรุงเทพมหานคร 10120',
};

const List<dynamic> openingDate = [
  {'day': 'วันอังคาร วันศุกร์ วันเสาร์', 'time': '10:00-19:00'},
  {'day': 'วันพฤหัส', 'time': '15:00-19:00'},
];

const Map<String, String> medicineExplanation = {
  'Herb': 'เป็นประเภทที่เห็นผลเร็ว แต่อาจจะยุ่งยากในการต้ม',
  'Mash': 'เป็นประเภทที่ง่ายต่อการรับประทาน เห็นผลเร็วกว่าแบบเม็ด',
  'Pill': 'เป็นประเภทที่รับประทานง่ายที่สุด แต่อาจจะเห็นผลช้าสุด',
};

const Map<String, List<String>> medicineImageUrl = {
  'Herb': [
    'https://sv1.picz.in.th/images/2020/07/25/Ediw59.md.jpg',
    'https://sv1.picz.in.th/images/2020/07/25/Edi6EN.md.jpg',
    'https://sv1.picz.in.th/images/2020/07/25/EdinVV.md.jpg',
    'https://sv1.picz.in.th/images/2020/07/25/EdUTKf.md.jpg',
  ],
  'Mash': [
    'https://cg.lnwfile.com/_/cg/_raw/h5/h2/z9.jpg',
    'https://sites.google.com/site/reuxngnarunismunphirthiy/_/rsrc/1472782328740/ya-phng/untitled78.png',
    'https://cz.lnwfile.com/qqhtmh.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRFcgLsT8A0GMI3Zc-RKh4KLIifTqW92VS7xlbQ1HnoPg&usqp=CAU&ec=45707743',
  ],
  'Pill': [
    'https://cg.lnwfile.com/xt790a.jpg',
    'https://www.tupack.co.th/images/product-pharma/tablet-press-machine/SPT-series-ex01.jpg',
    'https://img.lovepik.com/element/40134/8944.png_860.png',
    'https://img.lovepik.com/element/40137/5994.png_860.png',
  ],
};

const Map<String, Map<String, String>> bankAccount = {
  'SCB': {
    'imageUrl':
        'https://i0.wp.com/www.myshineyhineythailand.com/wp-content/uploads/2019/01/scb-icon.png',
    'number': '087-210531-1',
    'accountName': 'นางสิริกร วิจิตรกิจจา',
    'bankName': 'ธนาคารไทยพาณิชย์'
  },
};

const List<String> decorationImage = [
  'lib/assets/images/clinic1.jpg',
  'lib/assets/images/clinic2.jpg',
  'lib/assets/images/clinic3.jpg',
];
