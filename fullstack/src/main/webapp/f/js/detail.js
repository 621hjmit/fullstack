const $dropdownBtn = $(".dropdown-btn");
const $dropdownBtnToggler = $(".dropdown-btn-toggler");
const $thumbItem = $(".thumb-item");
const $sizeBtn = $(".size-btn");
const $colorBtn = $(".color-btn");
const $prdSection = $(".prd-section");
const $zoomThumbItem = $(".zoom-thumb-item");
const $zoomClose = $(".zoom-close");
const $zoom = $(".zoom");
const $prdImage = $(".prd-image>img");
const $zoomBigImage = $(".zoom-big-img>img");
const $plus = $(".zoom-plus-minus-wrap>.plus");
const $minus = $(".zoom-plus-minus-wrap>.minus");
const $thumb = $(".zoom-scroll-thumb");
const $rail = $(".zoom-scroll");

let calc;
let calcFlag;
let originalImageHeight = 0;
let initialImageHeight = 0;
let resultHeight = 0;
let thumbPosition = 0;
var pcFlag;
let slideSpeed = 100;
var cursorPos = 0,
  newCursorPos = 0;


$thumb.on("mousedown", dragMouseDown);

// var prditemSetpositionFlag;
//console.log( $zoomBigImage.height());
// $(".width-size").html($(this).width());

var swiper = new Swiper(".mySwiper", {
  spaceBetween: 0,
  centeredSlides: true,
  autoplay: false,
  pagination: {
    el: ".swiper-pagination",
    clickable: true,
  },
  loop: true,
});
swiper.on("click", function () {
  $zoom.addClass("on");
});
checkDevice();
setClassMobile();

$dropdownBtn.click(function () {
  var $this = $(this);
  if ($this.hasClass("open")) {
    $this.removeClass("open");
    $this.next().slideUp(slideSpeed);
  } else {
    $(".dropdown-btn.open").next().slideUp();
    $(".dropdown-btn.open").removeClass("open");
    $this.addClass("open");
    $this.next().slideDown(slideSpeed);
  }
  return false;
});

$sizeBtn.click(function () {
  $this = $(this);
  let index = $(this).index() - 1;
  $(".size-btn.checked").removeClass("checked");
  $this.addClass("checked");
  $("#size-original-btn>input").eq(index).prop("checked", true);
  return false;
});

$colorBtn.click(function () {
  $this = $(this);
  let index = $(this).index() - 1;
  $(".color-btn.checked").removeClass("checked");
  $this.addClass("checked");
  $("#color-original-btn>input").eq(index).prop("checked", true);
  return false;
});

$thumbItem.click(function (e) {
  e.preventDefault();
  var $this = $(this);
  if ($this.hasClass("on")) {
    //do nothing
  } else {
    $(".thumb-item.on").removeClass("on");
  }
  $this.addClass("on");

  var index = $(".thumb-item.on").index();
  $(".zoom-thumb-item.on").removeClass("on");
  $zoomThumbItem.eq(index).addClass("on");

  let url = $this.attr("href");
  $prdImage.hide();
  $prdImage.attr("src", url).fadeIn();
});

$zoomThumbItem.click(function (e) {
  e.preventDefault();
  var $this = $(this);

  if ($this.hasClass("on")) {
    //do nothing
  } else {
    $(".zoom-thumb-item.on").removeClass("on");
  }
  $this.addClass("on");
  let url = $this.attr("href");
  $zoomBigImage.hide();
  $zoomBigImage.attr("src", url).fadeIn();
  resultHeight = initialImageHeight;
  thumbPosition = 0;
  $zoomBigImage.css("height", resultHeight);
  $zoomBigImage.parent().addClass("notDraggable");
  $thumb.css("bottom", 0);
});
$zoomClose.click(function () {
  $zoom.removeClass("on");

  $("body").removeClass("fix");
  return false;
});

$(document).keydown(function (e) {
  e.preventDefault();
  //console.log($zoom.hasClass('on'));
  if (e.which == 38 && $zoom.hasClass("on")) {
    zoomIn(3);
    return false;
  }
  if (e.which == 40 && $zoom.hasClass("on")) {
    zoomOut(3);
    return false;
  }
  if (e.which == 107 && $zoom.hasClass("on")) {
    zoomIn(3);
    return false;
  }
  if (e.which == 109 && $zoom.hasClass("on")) {
    zoomOut(3);
    return false;
  }

  if (e.which == 27 && $zoom.hasClass("on")) {
    $zoom.removeClass("on");
    return false;
  }
});
$('.prd-image').click(function () {
  $zoom.addClass("on");
  $("body").addClass("fix");
  var url = $(".zoom-thumb-item.on").attr("href");
  $zoomBigImage.hide();
  $zoomBigImage.attr("src", url).fadeIn();
  if (!calcFlag) {
    initialImageHeight = $zoomBigImage.height();
    originalImageHeight = $zoomBigImage.prop("naturalWidth");
    resultHeight = initialImageHeight;
    calc = originalImageHeight - initialImageHeight;
    calcFlag = true;
  }
  $thumb.css("bottom", 0 + "%");
  $zoomBigImage.css("height", initialImageHeight);
  $zoomBigImage.parent().addClass("notDraggable");

  return false;
});

$plus.click(function () {
  zoomIn(3);
});
$minus.click(function () {
  zoomOut(3);
});
$(window).bind('wheel', function(event){
  if (event.originalEvent.wheelDelta > 0 || event.originalEvent.detail < 0) {
      // scroll up
      zoomIn(10);
  }
  else {
      // scroll down
      zoomOut(10);
  }
});
//윈도우 리사이즈시 실행 영역 ---------------------


$(window).on("resize", function () {
  //$(".width-size").html($(this).width());
  checkDevice();
  setClassMobile();
});

//-------------------------------------------------
function zoomIn(divide) {
  thumbPosition += 85 / divide;
  resultHeight = resultHeight + calc / divide;
  if (thumbPosition > 85) {
    thumbPosition = 85;
    resultHeight = originalImageHeight;
  }

  $zoomBigImage.css("height", resultHeight);
  $thumb.css("bottom", thumbPosition + "%");
  $zoomBigImage.draggable();
  $zoomBigImage.parent().removeClass("notDraggable");
  return false;
}
function zoomOut(divide) {
  if (!calc) {
    calc = 0;
  }
  //85인 이유는 100에서 $thumb의 height만큼 빼면 그게 85%임.
  thumbPosition -= 85 / divide;
  resultHeight = resultHeight - calc / divide;
  if (thumbPosition < 5) {
    resultHeight = initialImageHeight;
    thumbPosition = 0;

    if (
      !$zoomBigImage.hasClass("destroyed") &&
      $zoomBigImage.hasClass("ui-draggable")
    ) {
      // 이미 draggable이 destroy되었으면 destroy를 하지 않는다.
      // 처음 열어서 ui-draggable이 적용된 적이 없으면 destroy를 하지 않는다.
      $zoomBigImage.draggable("destroy").addClass("destroyed");
    }
    $zoomBigImage.parent().addClass("notDraggable");
  }
  $zoomBigImage.css("height", resultHeight);
  $thumb.css("bottom", thumbPosition + "%");
  return false;
}
function setClassMobile() {
  if (!pcFlag) {
    //mobile
    $prdSection.addClass("mobile");
    $zoom.addClass("mobile");
  } else {
    $prdSection.removeClass("mobile");
    $zoom.removeClass("mobile");
  }
}
function checkDevice() {
  if ($(window).width() < 752) {
    pcFlag = false;
  } else {
    pcFlag = true;
  }
}
function dragMouseDown(e) {
  e.preventDefault();
  // 시작 시 마우스 커서 위치를 가져옵니다:
  newCursorPos = e.clientY;
  $(document).on("mouseup", closeDragElement);
  // 커서가 움직일 때마다 함수를 호출합니다:
  $(document).on("mousemove", elementDrag);
}

function elementDrag(e) {
  e.preventDefault();
  // 움직인 커서 위치
  let flagZoomIn = false;

  if (newCursorPos > e.clientY) {
    //zoomin
    flagZoomIn = true;
  } else {
    //zoomout
    flagZoomIn = false;
  }
  newCursorPos = e.clientY;

  //346 516
  //a = 85;
  //calc = newCursorPos-346-15
  // 346 = $rail.offset().top 을 의미. 15는 $thumb의 height 가 30 이라 중앙을 찍으면 15임. 그래서 그 정도를 빼준것임.
  //-346-15 = -361 이니까 이거를 아래 변수에 넣어주겠음. -361

  thumbPosition = (170 - (newCursorPos - 361)) / 2;

  if (thumbPosition <= 0) {
    thumbPosition = 0;
  }
  if (thumbPosition >= 85) {
    thumbPosition = 85;
  }
  let a = (thumbPosition + " ").indexOf(".");
  if (a < 1) {
    if (flagZoomIn) {
        scrollZoomIn();
      } else {
        scrollZoomOut();
      }
  }
  //console.log(thumbPosition);
  //$thumb.css("bottom", calc + "%");
}
function scrollZoomIn() {
  resultHeight = initialImageHeight + (calc / 85 * thumbPosition);
  if (thumbPosition == 85) {
    resultHeight = originalImageHeight;
  }

  $zoomBigImage.css("height", resultHeight);
  $thumb.css("bottom", thumbPosition + "%");
  $zoomBigImage.draggable();
  $zoomBigImage.parent().removeClass("notDraggable");
  return false;
}
function scrollZoomOut() {
    resultHeight = initialImageHeight + (calc / 85 * thumbPosition);
    if (thumbPosition < 1) {
        resultHeight = initialImageHeight;
        thumbPosition = 0;
    
        if (
          !$zoomBigImage.hasClass("destroyed") &&
          $zoomBigImage.hasClass("ui-draggable")
        ) {
          // 이미 draggable이 destroy되었으면 destroy를 하지 않는다.
          // 처음 열어서 ui-draggable이 적용된 적이 없으면 destroy를 하지 않는다.
          $zoomBigImage.draggable("destroy").addClass("destroyed");
        }
        $zoomBigImage.parent().addClass("notDraggable");
      }
      $zoomBigImage.css("height", resultHeight);
      $thumb.css("bottom", thumbPosition + "%");
  return false;
}
function closeDragElement() {
  // 마우스 버튼이 놓여지면 이동을 중단합니다:
  $(document).off("mouseup", closeDragElement);
  $(document).off("mousemove", elementDrag);
}
