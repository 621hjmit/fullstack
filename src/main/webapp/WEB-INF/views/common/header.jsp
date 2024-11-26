<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <title>Advantage full-stack project</title>
  <meta charset='utf-8'>
  
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
	<meta name='viewport' content='width=device-width, initial-scale=1.0'>
	<meta name='Title' content='Advantage full-stack project'>
	<meta name='Subject' content='Advantage full-stack project'>
	<meta name='Keywords' content='Advantage, full-stack, project'>
	<meta name='Author' content='Advantage'>
	<meta name='Publisher' content='Advantage'>
	<meta name='Description' content=''>
	<meta name='Author-Date' content=''>
	<meta name='Copyright' content=''>
  <meta name="robots" content="noindex, nofollow">
  

  <!-- 접근성 텍스트(skip) 숨김 -->
  <style>
     #skip {
        overflow: hidden;
        position: absolute;
        width: 0;
        height: 0;
        line-height: 0;
        text-indent: -9999px;
     }
  </style>

  <!-- 폰트어썸 -->
  <!-- <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.5.0/css/all.css'>
  <link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/fontawesome.min.css' rel='stylesheet'> -->
  <script src="https://kit.fontawesome.com/72a43b892a.js" crossorigin="anonymous"></script>

  <!-- 구글폰트 아이콘 -->
  <link rel='stylesheet'
     href='https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0'>

  <!-- 제이쿼리 3.7 CDN -->
  <script src='https://code.jquery.com/jquery-3.7.1.min.js' crossorigin='anonymous'></script>
  <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script> <!-- 메뉴 스윽 나올때 필요함. -->

  <!-- reset -->
  <link rel='stylesheet' href='/static/css/reset.css' />

  <!-- 로컬 CSS -->
  <link rel='stylesheet' href='/static/css/style.css' />
	<script>
	  const imgPath = '/uploads/'
	</script>
  <!-- 로컬 js -->
  <script src='/static/js/common.js' defer></script>
  <script src='/static/js/script.js' defer></script>
  <script src='/static/js/main.js' defer></script>

</head>

<body>
   <!-- 시각장애인 웹 접근성을 위한 skip _ 지우지않아도 됩니다. -->

   <ul id='skip'>
      <li><a href='#header'>헤더 바로가기</a></li>
      <li><a href='#nav'>메뉴 바로가기</a></li>
      <li><a href='#content'>내용 바로가기</a></li>
      <li><a href='#footer'>하단 바로가기</a></li>
   </ul>

   <!-- 공백을 위한 공간입니다. -->
   <header id="header">
      <!-- topnavi -->
      <section id="topnavi">
<!--          <ul>
            <li><a href="#">대한민국</a></li>
            <li><a href="#">매장찾기</a></li>
            <li><a href="contact.html">고객센터</a></li>
         </ul> -->
      </section>
      <!-- 메뉴, 로고, 오른쪽 메뉴 섹션 -->
      <div id="mainRowNavi">
         <div id="leftMenu">
            <button id="menu" class="menubtns">
               <i class="nav-bars"></i>
               <span>메뉴</span>
            </button>

            
         </div>

         <a id="logo" class="hide-in-mobile" href="/">
            <span class="hiddentext">fullstack paris</span>
         </a>
         <a id="logo2" class="show-in-mobile" href="/">
            <span class="hiddentext">fullstack paris</span>
         </a>

         <ul id="rightMenu">
            <li>
              <c:choose>
                <c:when test="${user != null}">
                 <button class="menubtns" onclick='location.href="/views/user/mypage"'>
                    <i class="nav-user"></i>
                    <a href="/views/user/mypage">마이페이지</a>
                 </button>
               </c:when>
               <c:otherwise>
                 <button class="menubtns" onclick='location.href="/views/user/login"'>
                    <i class="nav-user"></i>
                    <a href="/views/user/login">로그인</a>
                 </button>
               </c:otherwise>
              </c:choose>
            </li>
            <li>
               <button class="menubtns" id="shoppingbag" onclick='location.href="/views/order/cart"'>
                  <i class="nav-shopping"></i>
                  <a href="/views/order/cart">장바구니</a>
               </button>
            </li>
         </ul>
      </div>
      <div id="searchBackground" class="searchBackground"></div>
      <div id="mainRowNaviBack" class="show-in-mobile"></div>
   </header>
   <%@ include file="/WEB-INF/views/common/nav.jsp" %>
   <!-- 헤더 끝 기분좋아서 주석 쿠헤헤 -->