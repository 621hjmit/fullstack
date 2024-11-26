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

// 상품 상세 정보 로드 함수 추가 (Axios 사용)
$(document).ready(async function() {
	const piId = new URLSearchParams(location.search).get('piId');

	if (piId) {
		try {
			const response = await axios.get(`/product/${piId}`);

			if (response.status === 200) {
				const productData = response.data;

				// 제품 정보 동적 업데이트
				$("#piName").text(productData.piName || "상품명 없음");
				$("#piPrice").text(productData.piPrice ? Number(productData.piPrice).toLocaleString() : "가격 없음");
				$("#piCode").text(productData.piCode || "코드 없음");

				// 컬러 타이틀 업데이트
				if (productData.piColorTitle) {
					$("#prdColor .prd-info-items-header span").text(productData.piColorTitle);
				} else {
					$("#prdColor .prd-info-items-header span").text("컬러 정보 없음");
				}

				// 이미지 및 색상 정보 업데이트
				if (productData.productImgs && Array.isArray(productData.productImgs)) {
					const swiperWrapper = $(".swiper-wrapper");
					const thumbList = $("#thumbList");
					swiperWrapper.empty();
					thumbList.empty();

					productData.productImgs.forEach((img, index) => {
						// 이미지 경로 설정
						const imgSrc = `/uploads/${img.pimgUrl}`;

						// 슬라이드 이미지 추가
						swiperWrapper.append(`
              <div class="swiper-slide"><img src="${imgSrc}" alt="${productData.piName}"></div>
            `);

						// 썸네일 이미지 추가
						if (index === 0) {
							thumbList.append(`
                <a class="thumb-item on" href="${imgSrc}"><img src="${imgSrc}" alt="보기: 이미지: ${productData.piName}"></a>
              `);
						} else {
							thumbList.append(`
                <a class="thumb-item" href="${imgSrc}"><img src="${imgSrc}" alt="보기: 이미지: ${productData.piName}"></a>
              `);
						}
					});

					// 첫 번째 이미지를 메인 이미지로 설정
					if (productData.productImgs.length > 0) {
						const mainImgSrc = `/uploads/${productData.productImgs[0].pimgUrl}`;
						$("#mainImage").attr("src", mainImgSrc);
					}

					// 컬러 버튼 동적 생성 (메인 이미지 하나만 사용)
					if (productData.productImgs.length > 0) {
						const mainImgSrc = `/uploads/${productData.productImgs[0].pimgUrl}`;
						const colorContainer = $(".prd-info-items-body.flex.border-top");
						colorContainer.empty();
						productData.colorList.forEach((color, index) => {
							colorContainer.append(`
                <button class="color-btn ${index === 0 ? 'checked' : ''}" data-img-src="${mainImgSrc}">
                  <img src="${mainImgSrc}" alt="${color.pcName}">
                </button>
              `);
						});
					}
				}

				// 사이즈 버튼 동적 생성
				if (productData.sizeList && Array.isArray(productData.sizeList)) {
					const sizeContainer = $("#size-original-btn");
					sizeContainer.empty();
					productData.sizeList.forEach((size, index) => {
						const checked = index === 0 ? 'checked' : '';
						sizeContainer.append(`
              <input class="radioSize" type="radio" id="size${size.psName}" name="size" value="${size.psName}" ${checked}>
              <label for="size${size.psName}">${size.psName}</label>
            `);
					});

					// 사이즈 버튼 클릭 시 표시되는 사이즈 업데이트
					const sizeBtnContainer = $("#prdSize .prd-info-items-body");
					sizeBtnContainer.empty();
					productData.sizeList.forEach((size, index) => {
						sizeBtnContainer.append(`
              <button class="size-btn ${index === 0 ? 'checked' : ''}" data-size="${size.psName}">${size.psName}</button>
            `);
					});
					
					// 사이즈 버튼 클릭 시 선택한 사이즈 표시 및 hidden input에 값 저장
					    $(".size-btn").click(function() {
					        $(".size-btn.checked").removeClass("checked");
					        $(this).addClass("checked");
					        const selectedSize = $(this).data("size");
					        console.log(selectedSize);

					        // 선택한 사이즈를 hidden input에 저장
					        $("#selectedSize").val(selectedSize);
					    });

					// 사이즈 버튼 클릭 시 선택한 사이즈 표시
					$(".size-btn").click(function() {
						$(".size-btn.checked").removeClass("checked");
						$(this).addClass("checked");
						const selectedSize = window.$(this).data("size");
						console.log(selectedSize);
					});
				}

				// 소재 타이틀 업데이트
				if (productData.materialList && productData.materialList.length > 0) {
					const materialTitle = productData.piMaterialTitle;
					$("#productMaterial").text(materialTitle);
				}

				// 메인 정보 리스트 업데이트
				if (productData.mainInfoList && Array.isArray(productData.mainInfoList)) {
					const mainInfoListContainer = $("#mainInfoContainer");
					mainInfoListContainer.empty();
					productData.mainInfoList.forEach((info, index) => {
						// 메인 정보의 첫 번째 항목 위에 공간 추가
						const spaceStyle = index === 0 ? "style='margin-top: 20px;'" : "";
						mainInfoListContainer.append(`
						              <p ${spaceStyle}>- ${info.pmiDesc}</p>
						            `);
					});
				}

				// 제조국 정보 업데이트
				if (productData.piCountryOfOrigin) {
					$("#productCountryOfOrigin").text(`${productData.piCountryOfOrigin} 제조`);
				} else {
					$("#productCountryOfOrigin").text("제조국 정보 없음");
				}

				// 제품 세부 정보 동적 업데이트
				if (productData.productDetailInfo) {
					const detailInfo = productData.productDetailInfo;
					$("#productDetailInfo").text(`모델 정보: 키 ${detailInfo.pdiHeight}cm, ${detailInfo.pdiSize}사이즈 착용`);
				} else {
					$("#productDetailInfo").text("제품 세부 정보가 없습니다.");
				}

				// 썸네일 클릭 시 메인 이미지 변경 기능 추가 (페이드 효과 적용)
				$(".thumb-item").click(function(e) {
					e.preventDefault();
					const selectedImgSrc = $(this).attr("href");

					// 현재 선택된 썸네일에 'on' 클래스 추가
					$(".thumb-item.on").removeClass("on");
					$(this).addClass("on");

					// 메인 이미지 페이드 아웃 후 교체, 다시 페이드 인
					$("#mainImage").fadeOut(300, function() {
						$(this).attr("src", selectedImgSrc).fadeIn(300);
					});
				});

				// 추가 정보 로드 (/productAddInfo 호출)
				const addInfoResponse = await axios.get('/productAddInfo');
				if (addInfoResponse.status === 200) {
					const productAddInfo = addInfoResponse.data;

					if (productAddInfo && productAddInfo.length > 0) {
						const addInfoContainer = $("#productAddInfoList");
						addInfoContainer.empty();
						productAddInfo.forEach((info) => {
							addInfoContainer.append(`
		                <li>${info.paiDesc}</li>
		            `);
						});
					} else {
						console.error("No additional product information found.");
					}
				}




			} else {
				console.error("Failed to fetch product details.");
			}
		} catch (error) {
			console.error("Error fetching product data:", error);
		}
	}
});







































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
swiper.on("click", function() {
	$zoom.addClass("on");
});
checkDevice();
setClassMobile();

$dropdownBtn.click(function() {
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

$sizeBtn.click(function() {
	$this = $(this);
	let index = $(this).index() - 1;
	$(".size-btn.checked").removeClass("checked");
	$this.addClass("checked");
	$("#size-original-btn>input").eq(index).prop("checked", true);
	return false;
});

$colorBtn.click(function() {
	$this = $(this);
	let index = $(this).index() - 1;
	$(".color-btn.checked").removeClass("checked");
	$this.addClass("checked");
	$("#color-original-btn>input").eq(index).prop("checked", true);
	return false;
});

$thumbItem.click(function(e) {
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

$zoomThumbItem.click(function(e) {
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
$zoomClose.click(function() {
	$zoom.removeClass("on");

	$("body").removeClass("fix");
	return false;
});

$(document).keydown(function(e) {
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
$('.prd-image').click(function() {
	$zoom.addClass("on");
	$("body").addClass("fix");
	var url = $(".zoom-thumb-item.on").attr("href");
	$zoomBigImage.hide();
	$zoomBigImage.attr("src", url).fadeIn();
	if (!calcFlag) {
		initialImageHeight = $zoomBigImage.height();
		//originalImageHeight = $zoomBigImage.prop("naturalWidth");
		originalImageHeight = 1600;
		resultHeight = initialImageHeight;
		calc = originalImageHeight - initialImageHeight;
		calcFlag = true;
	}
	$thumb.css("bottom", 0 + "%");
	$zoomBigImage.css("height", initialImageHeight);
	$zoomBigImage.parent().addClass("notDraggable");

	return false;
});

$plus.click(function() {
	zoomIn(3);
});
$minus.click(function() {
	zoomOut(3);
});
$(window).bind('wheel', function(event) {
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


$(window).on("resize", function() {
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