"use strict";

// التأكد من تحميل الصفحة بالكامل
document.addEventListener("DOMContentLoaded", function () {
  console.log("BuildSafe Gaza: JS Ready ✅");
});

// نموذج التواصل (Contact Form)
document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("contactForm");
  /*
  التحقق من وجود نموذج التواصل في الصفحة
  */
   if(form){
      form.addEventListener("submit", function (e) {
      // منع الإرسال الافتراضي للنموذج
      e.preventDefault();

      // تنبيه المستخدم بنجاح إرسال الرسالة 
      alert("تم إرسال الرسالة بنجاح ✔️ ");

      form.reset(); // تفريغ الحقول
  });
   }

});

// نموذج المعاينة (Assessment Form)
document.addEventListener("DOMContentLoaded", function () {
  const assessmentForm = document.getElementById("assessmentForm");

  const viewBtn = document.getElementById("viewReportBtn");
  const printBtn = document.getElementById("printReportBtn");

 //  التعامل مع إرسال نموذج المعاينة
  if (assessmentForm) {
    assessmentForm.addEventListener("submit", function (e) {
      e.preventDefault();
     // رسالة تأكيد حفظ البيانات 
      alert("تم حفظ المعاينة بنجاح ✔️ ");
      // إعادة تعيين النموذج
      assessmentForm.reset();
    });
  }
   // زر عرض التقرير من داخل Modal
    if (viewBtn) {
    viewBtn.addEventListener("click", function () {

      // إغلاق الـ Modal
      const modalEl = document.getElementById("reportModal");
      const modal = bootstrap.Modal.getInstance(modalEl);
      modal.hide();

      // إظهار التقرير
      const reportSection = document.getElementById("reportSection");
      reportSection.classList.remove("d-none");

      // Scroll للتقرير
      reportSection.scrollIntoView({ behavior: "smooth" });
    });
  }
});

// دالة انشاء التقرير
function generateReport() {
  /*
  قراءة القيم المدخلة من نموذج المعاينة
  باستخدام DOM Manipulation
  */
  const buildingCode = document.getElementById("buildingCode").value;
  const location = document.getElementById("location").value;
  const buildingType = document.getElementById("buildingType").value;
  const occupancyStatus = document.getElementById("occupancyStatus").value;
  const floors = document.getElementById("floors").value;
  const damageType = document.getElementById("damageType").value;
  const buildingYear = document.getElementById("buildingYear").value;
  const riskLevel = document.getElementById("riskLevel").value;
  const notes = document.getElementById("notes").value || "—";
  const ownerName = document.getElementById("ownerName").value;
  const ownerId = document.getElementById("ownerId").value;
  const ownerPhone = document.getElementById("ownerPhone").value;

  const imageInput = document.getElementById("damageImages");
  const reportImages = document.getElementById("reportImages");

  // تفريغ الصور القديمة قبل إضافة صور جديدة
  reportImages.innerHTML = ""; 

  /*
  التحقق من تعبئة الحقول الأساسية
  في حال وجود نقص يتم إيقاف العملية
  */
  if (!buildingCode || !location || !buildingType || !floors || !damageType || !riskLevel  || !occupancyStatus || !ownerName || !ownerId || !ownerPhone) {
    alert("يرجى تعبئة جميع الحقول الأساسية");
    return;
  }
  /*
  تعبئة بيانات التقرير ديناميكيًا
  */
  document.getElementById("rOwnerName").textContent = ownerName;
  document.getElementById("rOwnerId").textContent = ownerId;
  document.getElementById("rOwnerPhone").textContent = ownerPhone;
  document.getElementById("rBuildingCode").textContent = buildingCode;
  document.getElementById("rLocation").textContent = location;
  document.getElementById("rBuildingType").textContent = buildingType;
  document.getElementById("roccupancyStatus").textContent = occupancyStatus;
  document.getElementById("rFloors").textContent = floors;
  document.getElementById("rDamageType").textContent = damageType;
    document.getElementById("rbuildingYear").textContent = buildingYear;
  document.getElementById("rRiskLevel").textContent = riskLevel;
  document.getElementById("rNotes").textContent = notes;

  document.getElementById("reportDate").textContent =
    new Date().toLocaleDateString("ar-EG");

 const reportModal = new bootstrap.Modal(
  document.getElementById("reportModal")
);
reportModal.show();

  document.getElementById("reportSection").scrollIntoView({ behavior: "smooth" });
  /*
  قراءة الصور المرفوعة وتحويلها إلى Data URL
  لعرضها داخل التقرير
  */
  if (imageInput.files.length > 0) {
  Array.from(imageInput.files).forEach(file => {
    const reader = new FileReader();

    reader.onload = function (e) {
      const img = document.createElement("img");
      img.src = e.target.result;
      reportImages.appendChild(img);
    };

    reader.readAsDataURL(file);
  });
}
}
