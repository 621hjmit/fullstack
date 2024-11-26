<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>
<!-- [Page specific CSS] start -->
<style>.w-50px{width:50px}</style>  
<!-- [Page specific CSS] end -->

<!-- [ Main Content ] start -->
<div class="pc-container">
  
  <div class="pc-content">
    <!-- [ page title ] start -->
    <div class="page-header">
      <div class="page-block">
        <div class="row align-items-center">
          <div class="col-md-12">
            <div class="page-header-title">
              <h2 class="mb-0">회원 등급 설정<button type="button" class="btn btn-icon btn-link-primary avtar-xs" data-bs-toggle="popover" 
              data-bs-title="회원 등급 설정"  data-bs-placement="bottom" data-bs-html="true"
              data-bs-content="
              <ul>
                <li>회원 등급을 설정합니다.</li>
              </ul>">
              <i class="ti ti-info-circle"></i></button></h2>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- [ page title ] end -->
    
    <div class="row">
      
      <!-- [ block1 : 회원 등급 출력 ] start -->
      <div class="col-lg-8">
        <div class="card table-card">
          <div class="card-body ">
            <div class="">
              <table class="table">
              	<thead>
              		<th scope="col"><input type="checkbox" onclick="check_all('check', this);" class="allChk"></th>
					      <th scope="col">등급 이름</th>
					      <th scope="col">등급 설명</th>
					      <th scope="col">순서</th>
              	</thead>
              	<tbody id="gradeList">
              	</tbody>
              </table>
            </div>
            <div class="p-4 text-center">
            	<button type="button" class="btn btn-outline-primary btn-sm" onclick="updateGrades()">수정</button>
            	<button type="button" class="btn btn-outline-danger btn-sm" onclick="deleteGrades()">삭제</button>
            </div>
          </div>
        </div>
      </div>
      <!-- [ block1 : 회원 등급 출력 ] end -->
      <!-- [ block1 : 회원 등급 추가 ] start -->
      <div class="col-lg-4">
        <div class="card table-card">
          <div class="card-body ">
            <div class="p-4">
            	<input class="form-control mb-1" id="name" type="text" placeholder="회원 등급 명">
            	<input class="form-control" id="desc" type="text" placeholder="회원 등급 설명">
            </div>
            <div class="p-3 text-center">
            	<button type="button" class="btn btn-outline-primary btn-sm" onclick="insert()">추가</button>
            </div>
          </div>
        </div>
      </div>
      <!-- [ block1 : 회원 등급 추가 ] end -->
    </div>
  </div>
</div>
<!-- [ Main Content ] end -->

<!-- [Page Specific JS] start -->
<script src="/static/assets/js/plugins/simple-datatables.js"></script>
<script src="/static/js/admin/user/setting-grade.js"></script>
<!-- [Page Specific JS] end -->

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>