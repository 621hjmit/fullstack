<%@page import="com.shop.hermesplus.user.vo.UserInfoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 로컬 CSS -->
<link rel='stylesheet' href='/static/css/user/mypage-edit.css' />
<link rel='stylesheet' href='/static/css/terms.css' />

<!-- 헤더 끝 기분좋아서 주석 쿠헤헤 -->

<main id="main" class="margin-top-60 margin-bottom-60 mobile-margin-rl-15 user">
    <div class="main-container">
      <div class="flex flex-center">
        <div class=" w-20p">
          <%@ include file="/WEB-INF/views/common/mypage-nav.jsp" %>
        </div>
        <div class="bright-back-color w-80p">
          <div class="title flex space-between">
            <h1 class="boxed-title">1:1 문의내역</h1>
          </div>
          <div class="" id="">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col"><input type="checkbox" onclick="check_all('check', this);" class="allChk"></th>
                  <th scope="col" class="m-hidden">구분</th>
                  <th scope="col">제목</th>
                  <th scope="col" class="m-hidden">작성일</th>
                  <th scope="col">답변</th>
                </tr>
              </thead>
              <tbody id="boardList">
              </tbody>
            </table>
          </div>
          <div class="flex f-end p-20 ta-center">
            <button type="button" class="btn btn-border-black " onclick="deleteInquiryRecord()">삭제 하기</button>
            <button type="button" class="btn button-primary " onclick="location.href='/views/pages/contact'">문의 하기</button>
          </div>
        </div>
      </div>
    </div><!-- .main-container -->
</main>

<!-- 로컬 js -->
<script>
const user = '<c:out value="${user}"/>';
</script>
<script src='/static/js/script.js' defer></script>
<script src='/static/js/user/board-contact.js' defer></script>
<!-- 로컬 js end -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>