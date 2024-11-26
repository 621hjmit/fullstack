<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/views/common/min-header.jsp" %>

<!-- 로컬 CSS -->
<link rel='stylesheet' href='/static/css/style.css' />
<link rel='stylesheet' href='/static/css/cart.css' />

<!-- 로컬 js -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<!-- 헤더 끝 -->
	<main id="main" class="margin-bottom-60 order-main">
		<div class="progress margin-top-35 row m-row">
			<div class="col-sm-4">
				<p class="progress-header ta-center ">장바구니</p>
			</div>
			<div class="col-sm-4">
				<p class="progress-header ta-center selected">결제하기</p>
			</div>
			<div class="col-sm-4">
				<p class="progress-header ta-center">확인</p>
			</div>
		</div>
		
		<div class="row progress-ing hidden">
			<div class="col-sm-2"></div>
		</div>
		<div class="row progress-ing">
			<div class="col-sm-6"></div>
		</div>
		<div class="row progress-ing hidden">
			<div class="col-sm-10"></div>
		</div>
<!-- Cart main -->		
		<div class="row gap20 row-sm-col">
			<div class="col-md-8 row-col gap20"  id="paymentMain">
				<div class="bright-back-color cart-section" style="margin-top: 5px">
					<div class="info fw-bold">
						<p>주문회원계정</p><br>
						<dl class="options">
							<dt style="width:100px">이름</dt><dd id="uiName"></dd><br>
							<dt style="width:100px">이메일</dt><dd id="uiEmail"></dd><br>
							<dt style="width:100px">연락처</dt><dd id="uiPhone"></dd>
						</dl>
					</div>
				</div>
				<div class="bright-back-color cart-section" style="margin-top: 5px">
					<div class="info fw-bold">
						<p>배송지</p><br>
						<dl class="options">
							<dt style="width:100px">배송지 주소</dt><dd id="aiAddress1"></dd><br>
							<dt style="width:100px">배송지 연락처</dt><dd id="aiPhone"></dd><br>
							<dt style="width:100px">수령자 이름</dt><dd id="aiRecipentName"></dd>
						</dl>
						<div style="width: 100%; text-align: center;">
							<div style="width:300px ; display: inline-flex; margin-top:20px; padding: 0px; align-items: center; border: 1px solid #ccc; border-radius: 5px; overflow: hidden; height: 1.5em;">
								<button type="button" style="padding: 9px; width: 33%; font-size: 0.7em; color: #777; line-height: 1; border-right: 1px solid #ccc; background-color: #f0f0f0;" onclick="window.open('/views/order/address-modify-popup', '주소수정', 'width=600,height=800')">주소수정</button>
								<button type="button" style="padding: 9px; width: 33%; font-size: 0.7em; color: #777; line-height: 1; border-right: 1px solid #ccc; background-color: #f0f0f0;" onclick="window.open('/views/order/address-popup', '다른주소선택', 'width=600,height=800')">다른주소선택</button>
								<button type="button" style="padding: 9px; width: 33%; font-size: 0.7em; color: #777; line-height: 1; border: none; background-color: #f0f0f0;" onclick="window.open('/views/order/address-insert-popup', '주소추가', 'width=600,height=800')">주소추가</button>
							</div>
						</div>
					</div>
				</div>

				<div class="bright-back-color cart-section" style="margin-top: 5px">
					<div class="info fw-bold">
						<p>주문상품</p><br>
						<div id="goodsName"></div>
					</div>
					<div id="showItems"></div>
				</div>
				<div class="info fw-bold">
					<button onclick="requestPay()" class="cart-btn btn-200 btn-sm button-base button-primary">결제 하기</button>
				</div>';
<!-- Side 주문 부가 정보 -->
			</div>
			<div class="col-md-4 row-col gap20">
				<div class="bright-back-color">오렌지 박스</div>
				<div class="bright-back-color">에르메스 고객센터</div>
			</div>
		</div>
	</main>
	
<script>
let user = '<c:out value="${user}"/>';     // session에서 얻은 user (uiNum만 값이 있음)
let userObject = null;     // String인 user를 object화하여 담는 변수
let uiNum = 0;    //
let uiName = '';
let uiPhone = '';
let uiEmail = '';
let aiNum = 0;
<% String aiNum = request.getParameter("aiNum");%>
let aiAddress1 = '';
let aiAddress2 = '';
let itemCount = 0;
var IMP = window.IMP;
IMP.init('imp45375380'); // 가맹점 식별코드

window.onload = init;
function init(){
	console.log("성공1 user");
	console.log(user);
	
	// user가 string으로 되어있어서 object화 하고 uiNum을 얻는다.
	userObject = Object.fromEntries(
			user.match(/(\w+)=([^,]+)/g).map(pair => pair.split('=')));
	uiNum = userObject.uiNum;
	console.log("성공2 uiNum");
	console.log(uiNum);
	getUserData();
}

async function getUserData(){
	console.log("getUserData() 함수 진입!!");
	let params = {
			uiNum : Number(uiNum)
	}
	console.log(">> params");
	console.log(params);
	axios.post('/orderUser',params)
	.then(response =>{
		console.log("성공4 서버에서 불러온 user 정보(response.data)");
		console.log(response.data);
		uiName = response.data.uiLastName + response.data.uiFirstName
		document.querySelector('#uiName').innerText = uiName;
		document.querySelector('#uiEmail').innerText = response.data.uiEmail;
		document.querySelector('#uiPhone').innerText = response.data.uiPhone;
		getDeliveryInfo(aiNum);
	});
}

async function getDeliveryInfo(aiNum){
	console.log("showDeliveryInfo() 함수 진입!!");
	let address = null;
	if(aiNum==0 || aiNum ==undefined){
		let params = {
				uiNum : Number(uiNum)
		}
		console.log("params :");
		console.log(params);

		axios.post('/orderAddr',params)
		.then(response =>{
			address = response.data;
			console.log("성공5 address :");
			console.log(address);
			aiNum = address.aiNum;
			showDeliveryInfo(address);
		});
	}else{
		let params = {
				aiNum : Number(aiNum)
		}
		console.log("params :");
		console.log(params);
		axios.post('/orderAddr',params)
		.then(response =>{
			address = response.data;
			console.log("성공6 address :");
			console.log(address);
			showDeliveryInfo(address);
		});	
	}
}

function showDeliveryInfo(address){
	console.log(address.aiAddress1);
	console.log(address.aiAddress2);
	let deliveryAddress = address.aiAddress1 + ' ' + address.aiAddress2;
	document.querySelector('#aiAddress1').innerText = deliveryAddress;
	document.querySelector('#aiPhone').innerText = address.aiPhone;
	document.querySelector('#aiRecipentName').innerText = address.aiRecipentName;
	getPayItems();
}

async function getPayItems(){
	let params = {
			uiNum : Number(uiNum),
			oitStatus : "onPayment"
	}
	axios.get('/orderItemTemp', {params})
	.then(response => {
		console.log("성공");
		console.log(response.data);
		itemCount = response.data.count;
		console.log("상품 몇개?" + itemCount);
		payItems = response.data.list;
		console.log("결제중인 상품");
		console.log(payItems);
		
		loadPayItems();
	});
}

function loadPayItems(){
	let subtotal = 0;
	let deliveryFee = 0;
	let oitCountTotal = 0;
	let html='';
	payItems.forEach(payItem =>{
		html += '<div class="row cart-prd-list gap20 m-row" style="margin-bottom:30px;">';
		html += '<div><a href="/views/product/detail" target="_blank"><img src="/uploads/'+ payItem.pimgUrl +'"></a></div>';
		html += '<div>';
		html += '<p class="prd-name" id="piName">'+ payItem.piName +'</p>';
		html += '<dl class="options">';
		html += '<dt>제품번호 : </dt><dd>'+ payItem.piCode +'</dd><br>';
		html += '<dt>컬러:</dt><dd>'+ payItem.piColorTitle +'</dd>';
		html += '\t<dt>/ 크기:</dt><dd>'+ payItem.psName +'</dd></dl></div>';
		html += '<div class="ta-right">'+ payItem.piPrice.toLocaleString() +'</div>';
		html += '<div class="ta-right">'+ payItem.oitCount +' 개</div>';
		html += '<div class="ta-right">'+ (payItem.piPrice * payItem.oitCount).toLocaleString() +'</div>';
		html += '</div>';
		subtotal += payItem.piPrice * payItem.oitCount;
		oitCountTotal += payItem.oitCount;
	});
	if(subtotal >= 0){
		deliveryFee = 0;
	}else{
		deliveryFee = 0;
	}
	goodsName = payItems[0].piName+'  등 총 ' +oitCountTotal+ '개'
	totalAmount = subtotal+deliveryFee
	html += '<dl class="row-spbt"><dt>소계</dt><dd>' + subtotal.toLocaleString() + '</dd></dl>';
	html += '<dl class="row-spbt"><dt>배송비</dt><dd>' + deliveryFee.toLocaleString() + '</dd></dl>';
	html += '<dl class="row-spbt"><dt>총 결제액</dt><dd>' + (totalAmount).toLocaleString() + '</dd></dl>';
	
	document.querySelector('#goodsName').innerText = goodsName;
	document.querySelector('#showItems').innerHTML = html;
}



async function requestPay() {
	const orId = "ORD" + (new Date().getTime()) +"_" + uiNum;
	console.log("1. PG사에 결제요청");
 	IMP.request_pay({
		pg: "html5_inicis",
		pay_method: "card",
		merchant_uid: orId,
		name: goodsName,
		amount: totalAmount,
		buyer_email: uiEmail,
		buyer_name: uiName,
		buyer_tel: uiPhone,
	}, function (rsp) {
		if (rsp.success) {
       		console.log("rsp =======>");
       		console.log(rsp);
			//2. 결제 성공 시 Order data 생성
			console.log("2. Insert Order Data ");
			let param = {
				orId : orId,
				uiNum : Number(uiNum),
				uiName : uiName,
				orPiName : goodsName,
				orItemCount : itemCount,
				orAmount : totalAmount,
			}
			axios.post('/orders', param)
			.then(response => {
				console.log("<<OrderTable 저장 결과값 :");
				console.log(response.data);
				if(response.data == 1){
					console.log("2 order 생성 성공");
					console.log("rsp.imp_uid");
					console.log(rsp.imp_uid);
            		// 3. 결제 성공 시 검증 요청
					alert('결제가 완료되었습니다.');
					// 4. payment Info data 생성
					let payPg ='';
					param = {
						uiNum : Number(uiNum),
						payPg : rsp.pg_provider,
						payImpUid : rsp.imp_uid,
						payMethod : rsp.pay_method,
						orId : rsp.merchant_uid,
						orPiName : rsp.name,
						payAmount : rsp.paid_amount,
						payName : rsp.buyer_name,
						payStatus : rsp.status
					}
					axios.post('/payInfo', param)
					.then(response => {
						if(response.data == 2){
							console.log("4 paymentInfo 생성 성공");
							// 5. 찐 Order-Item data 생성
							console.log("5. Order-Item data 생성")
							console.log("주문 아이템 정보 확인(payItems) : ")
							console.log(payItems)
							let params = [];
							for(var i=0; i<itemCount ; i++){
								let param = {
									orId : orId,
									uiNum : payItems[i].uiNum,
									uiName : uiName,
									piId : payItems[i].piId,
									piName : payItems[i].piName,
									piCode : payItems[i].piCode,
									piColorTitle : payItems[i].piColorTitle,
									psName : payItems[i].psName,
									oiPrice : payItems[i].piPrice,
									oiCount : payItems[i].oitCount,
									oiStatus : "open",
									oiStatusPay : "결제완료",
									ciNum : payItems[i].ciNum    	    
								}
								params.push(param);
							}
							console.log("OrderItem 생성용 params");
							console.log(params);
							axios.post('/orderItems', params)
							.then(response =>{
		            			if(response.data == itemCount){
		        					console.log("temp order를 찐 order로 생성 성공");
		        					
		        					// 5. 가 주문 데이터 Status를 false로 변경하여 카트에서 삭제
		        					let oitNums = [];
		        					for(var i=0; i < itemCount; i++){
		        						oitNums.push(payItems[i].oitNum)
		        					};
		        					console.log("아이템 번호들")
		        					console.log(oitNums)
		        					const tempOrderParams = {
		        							list : oitNums,
		        							status : "finished"
		        					}
		        					axios.put('/changeMultiStatus', tempOrderParams)
		        					.then(res =>{
		        						if(res.data == itemCount){
		        							console.log("서버에도 잘 반영됨");
		        							console.log(res.data);
		        							alert("주문해주셔서 감사합니다. 정성껏 준비하여 보내드리겠습니다.");
		        							location.href='/';
		        						}else{
		        							console.log("서버에 반영 안됨");
		        							console.log(res.data);
		        						}
		        					})
		            			}else{
		            				console.log("찐 OrderItem 생성 실패")
		            			}
							});
						}else{
							console.log("4 paymentInfo 생성 실패");
						}
					});
				} else {
					console.log("2 order 생성 실패");
				}
			});
 		} else {
			alert('결제에 실패하였습니다. ' + rsp.error_msg);
		}
    });
}

</script>
	
<%@ include file="/WEB-INF/views/common/min-footer.jsp" %>