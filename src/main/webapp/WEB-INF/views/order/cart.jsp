<%@page import="com.shop.fullstack.UserInfoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/views/common/min-header.jsp" %>

<!-- 로컬 CSS -->
<link rel='stylesheet' href='/static/css/style.css' />
<link rel='stylesheet' href='/static/css/cart.css' />


<!-- 로컬 js -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<!-- 헤더 끝 기분좋아서 주석 쿠헤헤 -->
	<main id="main" class="margin-bottom-60 order-main">
		<div class="progress margin-top-35 row m-row">
			<div class="col-sm-4">
				<p class="progress-header ta-center selected">장바구니</p>
			</div>
			<div class="col-sm-4">
				<p class="progress-header ta-center ">결제하기</p>
			</div>
			<div class="col-sm-4">
				<p class="progress-header ta-center">확인</p>
			</div>
		</div>
		
		<div class="row progress-ing">
			<div class="col-sm-2"></div>
		</div>
		<div class="row progress-ing hidden">
			<div class="col-sm-6"></div>
		</div>
		<div class="row progress-ing hidden">
			<div class="col-sm-10"></div>
		</div>
<!-- Cart main -->		
		<div class="row gap20 row-sm-col">
			<div class="col-md-8 row-col gap20"  id="cartMain">
			</div>
<!-- Side 주문 부가 정보 -->
			<div class="col-md-4 row-col gap20">
				<div class="bright-back-color">오렌지 박스</div>
				<div class="bright-back-color">에르메스 고객센터</div>
			</div>
		</div>
	</main>
	
<script>	
<!-- 장바구니 로드 -->
let uiNum = '<c:out value="${user.uiNum}"/>';
let ciNum = 0;
let myCart = [];
let itemCount = 0;
let myItems = [];
let oitNums = []; // 장바구니 아이템 중 결제 화면으로 넘어갈 오더 아이템의 넘버모음 

const today = new Date().toLocaleDateString('ko-KR', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit'
    }).replace(/\. /g, '').replace('.', '');

window.addEventListener('load', () => checkUserInfo());

function checkUserInfo(){
	let html='';
	if(uiNum==null || uiNum ==""){
		html += '<div class="bright-back-color cart-section">';
		html += '<div class="info fw-bold">';
		html += '<p>에르메스 온라인 몰은 회원 전용입니다.<br><a href="/views/user/login">로그인</a>을 하시면 장바구니 정보를 확인하실 수 있습니다.</p>';
		html += '</div></div>';
		document.querySelector('#cartMain').innerHTML = html;
	}else {
		console.log(">>> 사용자 확인: "+uiNum);
		console.log("로그인 고객이니 카트 정보 확인하러 갑시다.")
		getCartNum();
	}
}
async function getCartNum(){
	console.log(">>> uiNum으로 cart 유무 확인하시오");
	let html='';
	html += '<div class="bright-back-color cart-section">';
	html += '<div class="info fw-bold">';
	const params = {
			uiNum : Number(uiNum),
			ciStatus : 1
	}
	console.log(params);
	axios.get('/cart',{params})
	.then(res1  => {
		console.log(res1.data);
		const cartCount = res1.data.count;
		console.log("카트 몇개? " + cartCount);
		if(cartCount==0){
			console.log(">>> uiNum으로 cart 없음");
			html += '<p>장바구니가 비어있습니다. 즐거운 쇼핑되세요.</p></div></div>';
			
		}else if(cartCount==1){
			console.log(">>> cart 있음!");
			myCart = res1.data.list;
			ciNum = myCart[0].ciNum;
			console.log("카트번호 :"+ciNum);
			console.log("카트번로 아이템 확인하러 가자");
			getCartItems();
		}
	});
}
async function getCartItems(){
	console.log(">>> ciNum :"+ciNum);
	console.log(myCart);
	const params = {
			ciNum : Number(ciNum),
			oitStatus : "true"
	}
	console.log(params);
	axios.get('/orderItemTemp', {params})
	.then(response => {
		console.log(response.data);
		itemCount = response.data.count;
		console.log("상품 몇개?" + itemCount);
		myItems = response.data.list;
		console.log(myItems);
		console.log("장바구니 제품 보여주러 가자");
		loadCart();
	});
}

function loadCart(){
	let subtotal = 0;
	let deliveryFee = 0;
	let html='';
	html += '<div class="bright-back-color cart-section">';
	html += '<div class="info fw-bold">';
	html += '<p>'+ itemCount +' 개의 상품이 장바구니에 담겨 있습니다.</p></div>';
	for(let i = 0; i < itemCount; i++){
		html += '<div class="row cart-prd-list gap20 m-row" style="margin-bottom:30px;">';
		html += '<div><a href="/views/product/detail" target="_blank"><img src="/uploads/'+myItems[i].pimgUrl+'"></a></div>';
		html += '<div>';
		html += '<p class="prd-name" id="piName">'+myItems[i].piName+'</p>';
		html += '<dl class="options">';
		html += '<dt>컬러:</dt><dd>'+myItems[i].piColorTitle+'</dd><br>';
		html += '<dt>크기:</dt><dd>'+myItems[i].psName+'</dd><br>';
		html += '<dt>제품 번호:</dt><dd>'+myItems[i].piCode+'</dd></dl></div>';
		html += '<div class="ta-right">'+myItems[i].piPrice.toLocaleString()+'</div>';
		html += '<div style="display: inline-flex; padding: 0px; align-items: center; border: 1px solid #ccc; border-radius: 5px; overflow: hidden; height: 2em;">';
		html += '<button type="button" style="padding: 3px; width: 20%; font-size: 1.5em; color: #aaa; line-height: 1; border: none; background-color: #f0f0f0;" onclick="changeCount(' + i + ', -1)">-</button>';
		html += '<input type="text" disabled style="width: 60%; text-align: center; border: none; outline: none; height: 100%; font-size: 1em;" value="' + myItems[i].oitCount + '">';
		html += '<button type="button" style="padding: 3px; width: 20%; font-size: 1.5em; color: #aaa; line-height: 1; border: none; background-color: #f0f0f0;" onclick="changeCount(' + i + ', 1)">+</button>';
		html += '</div>';
		html += '<div class="ta-right">'+(myItems[i].piPrice * myItems[i].oitCount).toLocaleString()+'</div>';
		html += '<button type="button" onclick="deleteOit('+ myItems[i].oitNum +')" style="padding: 3px; height: 1em; font-size: 1em; color: #6f5d4e; font-weight: bold; line-height: 1;">✕</button>';
		html += '</div>';
		subtotal += myItems[i].piPrice * myItems[i].oitCount;
	}
	if(subtotal >= 0){
		deliveryFee = 0;
	}else{
		deliveryFee = 0;
	}
	html += '<dl class="row-spbt"><dt>소계</dt><dd>' + subtotal.toLocaleString() + '</dd></dl>';
	html += '<dl class="row-spbt"><dt>배송</dt><dd>' + deliveryFee.toLocaleString() + '</dd></dl>';
	html += '<dl class="row-spbt"><dt>총 결제액</dt><dd>' + (subtotal+deliveryFee).toLocaleString() + '</dd></dl>';
	html += '<div class="prd-info-items"><div class="prd-info-items-body">';
	html += '<button onclick="moveToPay()" class="cart-btn btn-200 btn-sm button-base button-primary">결제 하기</button></div></div>';
	html += '</div>';
	document.querySelector('#cartMain').innerHTML = html;
}

async function changeCount(i,b){
	console.log(i,b);
	if(myItems[i].oitCount>=1){
		myItems[i].oitCount = myItems[i].oitCount + b;
	};
	if(myItems[i].oitCount<1){
		myItems[i].oitCount = 1;
	}
	const params = {
			oitNum: Number(myItems[i].oitNum),
			oitCount: Number(myItems[i].oitCount)
	}
	console.log(params);
	axios.put('/changeCount', params)
	.then(response=>{
		if(response.data==1){
			console.log("서버에도 잘 반영됨")
		}else{
			console.log("서버에 반영 안됨");
		}
	});
	loadCart();
}

async function deleteOit(oitNum){
	console.log(today);
	params = {
			oitNum: oitNum,
			oitStatus: 'false',
			oitClosedDate: today.replace('-', '')
	}
	axios.put('/changeStatus', params)
	.then(response=>{
		if(response.data==1){
			console.log("서버에도 잘 반영됨")
		}else{
			console.log("서버에 반영 안됨");
		}
	});
	getCartItems();
}
async function moveToPay(){
	for(var i=0; i < itemCount; i++){
		oitNums.push(myItems[i].oitNum)
	};
	console.log(oitNums);
	params = {
			list: oitNums,
			status: "onPayment"
	};
	axios.put('/changeMultiStatus', params)
	.then(response=>{
		if(response.data>0){
			console.log("서버에도 잘 반영됨");
			console.log(response.data);
		}else{
			console.log("서버에 반영 안됨");
			console.log(response.data);
		}
	});
	location.href='/views/order/pay';
}
</script>

<%@ include file="/WEB-INF/views/common/min-footer.jsp" %>