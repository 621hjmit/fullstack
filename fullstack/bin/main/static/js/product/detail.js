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
const $perfectPartnerContainer = $("#perfectPartnerContainer");
const $continueExploringContainer = $("#continueExploringContainer");


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

let productData = null;

$thumb.on("mousedown", dragMouseDown);

$(document).ready(async function() {
	const piId = new URLSearchParams(location.search).get('piId');

	// JSP에서 넘어온 uiNum 값 확인
	console.log("uiNum:", uiNum);

	if (uiNum == null || isNaN(uiNum)) {
		console.warn("uiNum이 올바르게 설정되지 않았습니다. 로그인 후 사용 가능합니다.");
	} else {
		console.log("uiNum이 정상적으로 설정되었습니다:", uiNum);
	}

	if (!piId) return;

	try {
		productData = await fetchProductData(piId);

		if (!productData) {
			console.error("제품 데이터를 로드하지 못했습니다.");
			return;
		}

		const mainCategoryId = productData.piMainCategoryId;
		const subCategoryId = productData.piSubCategoryId;
		const detailCategoryId = productData.piDetailCategoryId;

		// Call the recommendation functions
		if (mainCategoryId && subCategoryId) {
			await loadPerfectPartnerRecommendations(piId, mainCategoryId, subCategoryId);
		}
		if (detailCategoryId) {
			await loadContinueExploringRecommendations(piId, detailCategoryId);
		}

		updateProductInfo(productData);
		await updateStockInfo(piId);
		updateImages(productData);
		updateColorOptions(piId, productData);
		updateSizeOptions(productData);
		updateMaterialInfo(productData);
		updateMainInfo(productData);
		updateCountryOfOrigin(productData);
		updateDetailInfo(productData);
		await loadAdditionalProductInfo();
		await loadCareDescriptions(piId);
		await loadDeliveryInfo();
		await loadPaymentMethods();
		await loadRefundInfo();
		await loadGiftInfo();
		updateProductStory(productData);
		// 장바구니 기능 초기화
		initializeAddToCartButton();
	} catch (error) {
		console.error("제품 데이터 가져오기 오류:", error);
	}
});

// 장바구니 버튼 클릭 이벤트 설정 함수
function initializeAddToCartButton() {
	console.log("initializeAddToCartButton 호출됨");
	$(".cart-btn").click(function() {
		if (productData) {
			console.log("insertIntoCart 호출 전 productData:", productData);
			insertIntoCart(productData);
		} else {
			alert("제품 데이터를 불러오는 중 오류가 발생했습니다. 다시 시도해 주세요.");
		}
	});
}

// 장바구니에 제품 추가하는 함수
async function insertIntoCart(productData) {
	if (!productData) {
		return;
	}

	// productData에서 pimgUrl을 추가로 가져옵니다.
	const { piId, piName, piCode, piPrice, pimgUrl } = productData;
	const piColorTitle = document.querySelector('#selectedColor').innerText || '';
	const psName = window.selectedPsName || ''; // 전역 변수에서 선택된 사이즈 값을 가져옴

	if (uiNum == null || uiNum === "") {
		alert('로그인 후 사용 가능합니다.');
		location.href = "/views/user/login";
		return;
	}

	if (!psName) {
		alert('사이즈를 선택해 주세요.');
		return;
	}

	console.log('>>>>>장바구니 있는지 확인');
	let params = {
		uiNum: uiNum,
		ciStatus: 1
	};
	console.log(params);

	try {
		const res1 = await axios.get('/cart', { params });
		const cartCount = res1.data.count;

		if (cartCount == 0) {
			console.log('>>>>>장바구니가 없으니 만들자');
			const res2 = await axios.post('/cart', params);
			const cartOk = res2.data;

			if (cartOk == 1) {
				console.log('>>>>>장바구니 생성되었으니 temp 주문생성');
				const res3 = await axios.get('/cart', { params });
				const myCart = res3.data.list;
				const ciNum = myCart[0].ciNum;
				console.log(ciNum);
				addOrderItemTempLine(ciNum, productData, piColorTitle, psName, pimgUrl);
			} else if (cartOk == 0) {
				alert('죄송합니다. 장바구니 생성에 실패했습니다. 관리자에게 문의하세요.(031-000-0000)');
				console.log('>>>>>장바구니 생성 안됨');
			}
		} else if (cartCount == 1) {
			console.log('>>>>>장바구니가 있으니 temp 주문 체크');
			const myCart = res1.data.list;
			const ciNum = myCart[0].ciNum;
			console.log(ciNum);
			checkOrderItemTemp(ciNum, productData, piColorTitle, psName, pimgUrl);
		}
	} catch (error) {
		console.error('장바구니 확인 중 오류:', error);
	}
}

async function addOrderItemTempLine(ciNum, productData, piColorTitle, psName, pimgUrl) {
	console.log('>>>>>장바구니에 같은 상품이 없어 orderItem 생성');
	const params = {
		ciNum: ciNum,
		piId: Number(productData.piId),
		piName: productData.piName,
		piCode: productData.piCode,
		piPrice: Number(productData.piPrice),
		uiNum: Number(uiNum),
		piColorTitle: piColorTitle,
		psName: psName,
		oitCount: 1,
		oitStatus: 'true',
		pimgUrl: pimgUrl // 메인 이미지 URL 추가
	};
	console.log(params);

	try {
		const res6 = await axios.post('/orderItemTemp', params);
		if (res6.data == 1) {
			let answer = confirm("상품이 장바구니에 저장되었습니다. 확인 버튼을 누르면 장바구니로 이동합니다.");
			if (answer) {
				location.href = "/views/order/cart";
			}
		} else {
			alert('죄송합니다. 장바구니에 담기지 않았습니다. 관리자에게 문의하세요.(031-000-0000)');
		}
	} catch (error) {
		console.error('장바구니에 상품 추가 중 오류:', error);
	}
}

async function checkOrderItemTemp(ciNum, productData, piColorTitle, psName) {
	console.log('>>>>>동일한 order Item Temp 있는지 확인');
	let params = {
		ciNum: ciNum,
		piId: Number(productData.piId),
		piColorTitle: piColorTitle,
		psName: psName,
		oitStatus: 'true'
	};
	console.log(params);

	try {
		const res4 = await axios.get('/orderItemTemp', { params });
		const itemCount = res4.data.count;
		const itemList = res4.data.list;
		console.log('itemCount=' + itemCount);
		console.log(itemList);

		if (itemCount == 1) {
			console.log('동일한 상품이 있어 수량 +1 함수로 이동');
			modifyOrderItemTemp(itemList[0]);
		} else {
			console.log('장바구니에 동일한 상품 없어 상품 추가함수로 이동');
			addOrderItemTempLine(ciNum, productData, piColorTitle, psName);
		}
	} catch (error) {
		console.error('동일한 주문 아이템 확인 중 오류:', error);
	}
}

async function modifyOrderItemTemp(item) {
	console.log('>>>>> 기존 데이터에 수량 +1 저장');
	const params = {
		oitNum: Number(item.oitNum),
		oitCount: Number(item.oitCount) + 1
	};
	console.log(params);

	try {
		const res5 = await axios.put('/changeCount', params);
		console.log(res5.data);

		if (res5.data == 1) {
			alert("장바구니에 상품 수량이 추가되었습니다.");
		}
	} catch (error) {
		console.error('장바구니 수량 변경 중 오류:', error);
	}
}

async function addOrderItemTempLine(ciNum, productData, piColorTitle, psName) {
	console.log('>>>>>장바구니에 같은 상품이 없어 orderItem 생성');
	const params = {
		ciNum: ciNum,
		piId: Number(productData.piId),
		piName: productData.piName,
		piCode: productData.piCode,
		piPrice: Number(productData.piPrice),
		uiNum: Number(uiNum),
		piColorTitle: piColorTitle,
		psName: psName,
		oitCount: 1,
		oitStatus: 'true'
	};
	console.log(params);

	try {
		const res6 = await axios.post('/orderItemTemp', params);
		if (res6.data == 1) {
			let answer = confirm("상품이 장바구니에 저장되었습니다. 확인 버튼을 누르면 장바구니로 이동합니다.");
			if (answer) {
				location.href = "/views/order/cart";
			}
		} else {
			alert('죄송합니다. 장바구니에 담기지 않았습니다. 관리자에게 문의하세요.(031-000-0000)');
		}
	} catch (error) {
		console.error('장바구니에 상품 추가 중 오류:', error);
	}
}


//데이터 불러오기
async function fetchProductData(piId) {
	const response = await axios.get(`/product/${piId}`);
	return response.data;
}

//상품 기본정보 
function updateProductInfo(productData) {
	$("#piName").text(productData.piName || "상품명 없음");
	$("#piPrice").text(productData.piPrice ? Number(productData.piPrice).toLocaleString() : "가격 없음");
	$("#piCode").text(productData.piCode || "코드 없음");
}

//상품 재고 기능 -> 재고가 0이거나, 온라인 구매 불가능이면 장바구니 버튼 비활성화
async function updateStockInfo(piId) {
	const stockResponse = await axios.get(`/product-stock-info/${piId}`);
	const onlineResponse = await axios.get(`/product-online/${piId}`);
	const stockData = stockResponse.data;
	const isOnline = Boolean(onlineResponse.data.online);
	const cartButton = $(".cart-btn");

	if (isOnline && stockData && stockData.quantity > 0) {
		cartButton.prop("disabled", false).text("장바구니에 담기");
	} else {
		cartButton.prop("disabled", true).text("구매 불가");
	}
}

//상품 이미지 불러오기
function updateImages(productData) {
	const thumbList = $("#zoomThumbList").empty();
	const thumbListDetail = $("#thumbList").empty();
	const zoomBigImage = $("#zoomBigImage");
	const mainImage = $("#mainImage");

	productData.productImgs.forEach((img, index) => {
		const imgSrc = `/uploads/${img.pimgUrl}`;
		thumbList.append(`<a class="zoom-thumb-item ${index === 0 ? 'on' : ''}" href="${imgSrc}"><img src="${imgSrc}" alt="${productData.piName}"></a>`);
		thumbListDetail.append(`<a class="thumb-item ${index === 0 ? 'on' : ''}" href="${imgSrc}"><img src="${imgSrc}" alt="${productData.piName}"></a>`);
	});

	if (productData.productImgs.length > 0) {
		const mainImgSrc = `/uploads/${productData.productImgs[0].pimgUrl}`;
		zoomBigImage.attr("src", mainImgSrc);
		mainImage.attr("src", mainImgSrc);
	}

	$(".thumb-item").click(function(e) {
		e.preventDefault();
		const selectedImgSrc = $(this).attr("href");
		$(".thumb-item.on").removeClass("on");
		$(this).addClass("on");
		mainImage.hide().attr("src", selectedImgSrc).fadeIn(300);
	});

	$(".zoom-thumb-item").click(function(e) {
		e.preventDefault();
		const $this = $(this);
		if (!$this.hasClass("on")) {
			$(".zoom-thumb-item.on").removeClass("on");
			$this.addClass("on");
			zoomBigImage.hide().attr("src", $this.attr("href")).fadeIn(300);
		}
	});
}

//제품 색상 불러오기
async function updateColorOptions(piId, productData) {
	$("#prdColor .prd-info-items-header span").text(productData.piColorTitle || "컬러 정보 없음");
	const colorContainer = $(".prd-info-items-body.flex.border-top").empty();

	try {
		const linkedProductsResponse = await axios.get(`/colorProductLink/linked/${piId}`);
		const linkedProducts = linkedProductsResponse.data;

		if (linkedProducts.length > 0) {
			linkedProducts.forEach((linkedProduct) => {
				const imgSrc = linkedProduct.pimgUrl ? `/uploads/${linkedProduct.pimgUrl}` : '/path/to/default-image.jpg';
				colorContainer.append(`<button class="color-btn ${linkedProduct.piId === parseInt(piId) ? 'checked' : ''}" data-pi-id="${linkedProduct.piId}">
                    <img src="${imgSrc}" alt="${linkedProduct.piName}">
                </button>`);
			});
		} else {
			// 링크된 제품이 없을 때 기본 버튼 생성
			const imgSrc = productData.pimgUrl ? `/uploads/${productData.pimgUrl}` : '/path/to/default-image.jpg';
			colorContainer.append(`
                <button class="color-btn checked" data-pi-id="${piId}">
                    <img src="${imgSrc}" alt="${productData.piName}">
                </button>
            `);
		}
	} catch (error) {
		console.error("Error fetching linked products:", error);
	}

	$(".color-btn").click(function() {
		const selectedPiId = $(this).data("pi-id");
		if (selectedPiId) window.location.href = `/views/product/detail?piId=${selectedPiId}`;
	});
}

// 제품 사이즈 불러오기
function updateSizeOptions(productData) {
	const sizeContainer = $("#size-original-btn").empty();
	productData.sizeList.forEach((size, index) => {
		sizeContainer.append(`
            <input class="radioSize" type="radio" id="size${size.psName}" name="size" value="${size.psName}" ${index === 0 ? 'checked' : ''}>
            <label for="size${size.psName}">${size.psName}</label>
        `);
	});

	const sizeBtnContainer = $("#prdSize .prd-info-items-body").empty();
	productData.sizeList.forEach((size, index) => {
		sizeBtnContainer.append(`
            <button class="size-btn ${index === 0 ? 'checked' : ''}" data-size="${size.psName}">${size.psName}</button>
        `);
	});

	// 기본 선택된 사이즈를 전역 변수에 저장
	if (productData.sizeList.length > 0) {
		window.selectedPsName = productData.sizeList[0].psName;
	}

	// 사이즈 버튼 클릭 이벤트 추가
	$(".size-btn").click(function() {
		$(".size-btn.checked").removeClass("checked");
		$(this).addClass("checked");

		// 선택된 사이즈 값을 전역 변수에 저장
		const selectedSize = $(this).data("size");
		window.selectedPsName = selectedSize;

		// 콘솔 로그로 선택된 사이즈 값 확인
		console.log("선택된 사이즈:", window.selectedPsName);
	});
}

//제품 소재 불러오기
function updateMaterialInfo(productData) {
	$("#productMaterial").text(productData.piMaterialTitle || "소재 정보 없음");
}

//제품 메인정보 불러오기
function updateMainInfo(productData) {
	const mainInfoListContainer = $("#mainInfoContainer").empty();
	productData.mainInfoList.forEach((info) => {
		mainInfoListContainer.append(`<p style="margin-top: 20px;">- ${info.pmiDesc}</p>`);
	});
}

//제품 제조국 불러오깅
function updateCountryOfOrigin(productData) {
	$("#productCountryOfOrigin").text(productData.piCountryOfOrigin ? `${productData.piCountryOfOrigin} 제조` : "제조국 정보 없음");
}

//요건 제품 세부정보
function updateDetailInfo(productData) {
	const detailInfo = productData.productDetailInfo;
	$("#productDetailInfo").text(detailInfo ? `모델 정보: 키 ${detailInfo.pdiHeight}cm, ${detailInfo.pdiSize}사이즈 착용` : "제품 세부 정보가 없습니다.");
}

//이건 추가정보
async function loadAdditionalProductInfo() {
	try {
		const response = await axios.get('/productAddInfo?paiId=1');
		const addInfoContainer = $("#productAddInfoList").empty();
		response.data.forEach((info) => addInfoContainer.append(`<li>${info.paiDesc}</li>`));
	} catch (error) {
		console.error("추가 정보 로드 중 오류 발생:", error);
	}
}

//제품 소재에 따른 관리방법 불러오기
async function loadCareDescriptions(piId) {
	try {
		const response = await axios.get(`/product/care-desc/${piId}`);
		const careDescContainer = $("#productCareDesc").empty();
		response.data.forEach((desc) => careDescContainer.append(`<p>${desc}</p>`));
	} catch (error) {
		careDescContainer.html('<p>관리 방법 정보가 없습니다.</p>');
	}
}

//제품 배송정보 불러오기
async function loadDeliveryInfo() {
	const response = await axios.get('/productDeliveries');
	const shippingInfoList = $("#shippingInfoList").empty();
	response.data.forEach((info) => shippingInfoList.append(`<li>${info.pdDesc}</li>`));
}

//제품 결제정보 불러오기
async function loadPaymentMethods() {
	const response = await axios.get('/productPayments');
	const paymentMethodsList = $("#paymentMethodsList").empty();
	response.data.forEach((payment) => paymentMethodsList.append(`<li>${payment.ppDesc}</li>`));
}

//제품 환불정보 
async function loadRefundInfo() {
	const response = await axios.get('/productRefunds');
	const exchangeReturnsInfoList = $("#exchangeReturnsInfoList").empty();
	response.data.forEach((refund) => exchangeReturnsInfoList.append(`<li>${refund.prDesc}</li>`));
}

//제품 선물정보
async function loadGiftInfo() {
	const response = await axios.get('/productGifts');
	const giftInfoList = $("#prd-gift .prd-info-items-body ul").empty();
	response.data.forEach((gift) => giftInfoList.append(`<li>${gift.pgText}</li>`));
}

//제품 스토이 불러오기
function updateProductStory(productData) {
	$("#productStory").text(productData.piStory || "스토리 정보가 없습니다.");
}



// 완벽한 파트너 추천 제품을 로드하는 함수
async function loadPerfectPartnerRecommendations(piId, mainCategoryId, subCategoryId) {
	try {
		// piId를 URL 경로에 추가하고 나머지는 params로 설정
		const response = await axios.get(`/product/${piId}/recommendations`, {
			params: { piMainCategoryId: mainCategoryId, piSubCategoryId: subCategoryId }
		});

		const recommendations = response.data;
		const perfectPartnerContainer = $("#perfectPartnerContainer");
		perfectPartnerContainer.empty(); // 기존 추천 제품 초기화

		if (recommendations.length > 0) {
			recommendations.forEach(product => {
				perfectPartnerContainer.append(`
                    <li>
                        <a href="/views/product/detail?piId=${product.piId}">
                            <img src="/uploads/${product.pimgUrl}" alt="${product.piName}">
                            <p>${product.piName}</p>
							<p class="add-prd-info-price">${formatPrice(product.piPrice)}</p>
                        </a>
                    </li>
                `);
			});
		} else {
			perfectPartnerContainer.append(`<li>추천 제품이 없습니다.</li>`);
		}
	} catch (error) {
		console.error("추천제품 가져오기 오류:", error);
	}
}

// 계속 탐색하기 추천 제품을 로드하는 함수
async function loadContinueExploringRecommendations(productId, detailCategoryId) {
	try {
		const response = await axios.get(`/product/${productId}/explore`, {
			params: { detailCategoryId: detailCategoryId }
		});
		const recommendedProducts = response.data;

		// 컨테이너 초기화 후 추천 제품 추가
		$continueExploringContainer.empty();
		recommendedProducts.forEach(product => {
			$continueExploringContainer.append(`
                <li>
                    <a href="/views/product/detail?piId=${product.piId}">
                        <img src="/uploads/${product.pimgUrl}" alt="${product.piName}" />
                        <div class="add-prd-info">
                            <p class="add-prd-info-name">${product.piName}</p>
                           <p class="add-prd-info-price">${formatPrice(product.piPrice)}</p>
                        </div>
                    </a>
                </li>
            `);
		});
	} catch (error) {
		console.error("계속 탐색하기 추천 제품 로드 중 오류:", error);
	}
}

function formatPrice(price) {
	return '₩ ' + price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

//세부 페이지 줌기능 관련 함수
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

	const url = $(".zoom-thumb-item.on").attr("href");
	$zoomBigImage.hide();
	$zoomBigImage.attr("src", url).fadeIn();

	if (!calcFlag) {
		initialImageHeight = $zoomBigImage.height();
		originalImageHeight = $zoomBigImage.prop("naturalHeight");
		resultHeight = initialImageHeight;
		calc = originalImageHeight - initialImageHeight;
		calcFlag = true;
	}
	$thumb.css("bottom", "0%");
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
	resultHeight += calc / divide; // resultHeight 증가
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
	newCursorPos = e.clientY;
	$(document).on("mouseup", closeDragElement);
	$(document).on("mousemove", elementDrag);
}

function elementDrag(e) {
	e.preventDefault();
	let flagZoomIn = newCursorPos > e.clientY;
	newCursorPos = e.clientY;

	thumbPosition = (170 - (newCursorPos - 361)) / 2;
	thumbPosition = Math.max(0, Math.min(thumbPosition, 85));

	if (flagZoomIn) {
		scrollZoomIn();
	} else {
		scrollZoomOut();
	}
}

function scrollZoomIn() {
	resultHeight = initialImageHeight + (calc / 85 * thumbPosition);

	console.log("thumbPosition:", thumbPosition, "resultHeight:", resultHeight);

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
			$zoomBigImage.draggable("destroy").addClass("destroyed");
		}
		$zoomBigImage.parent().addClass("notDraggable");
	}
	$zoomBigImage.css("height", resultHeight);
	$thumb.css("bottom", thumbPosition + "%");
	return false;
}

function closeDragElement() {
	// 드래그 종료 시 이벤트 제거
	$(document).off("mouseup", closeDragElement);
	$(document).off("mousemove", elementDrag);
}



