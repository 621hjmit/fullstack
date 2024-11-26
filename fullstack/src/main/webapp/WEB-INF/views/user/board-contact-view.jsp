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
                <th scope="col" class="ta-center">구분</th>
                <th scope="col" class="ta-center">제목</th>
                <th scope="col" class="ta-center">작성일</th>
              </tr>
            </thead>
            <tbody id="boardContent">
            </tbody>
            <tfoot id="reply" class="hidden">
              <tr>
                <td colspan="2" class="pl-40-i">쇼핑몰 관리자 답변</td>
                <td id="ubReplyCredat" class="ta-center"></td>
              </tr>
              <tr>
	              <td colspan="3" class="p-20-i">
	                <div id="ubReplyMessage"></div>
	              </td>
              </tr>
            </tfoot>
          </table>
        </div>
        <div class="flex f-end p-20 ta-center">
          <button type="button" class="btn btn-border-black " onclick="updateInquiryRecord()">수정</button>
          <button type="button" class="btn btn-border-black " onclick="deleteInquiryRecord()">삭제</button>
          <button type="button" class="btn button-primary " onclick="location.href='/views/user/board-contact'">목록으로</button>
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
<script src='/static/js/user/board-contact-view.js' defer></script>
<!-- 로컬 js end -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>