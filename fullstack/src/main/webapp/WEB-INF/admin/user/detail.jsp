<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header-detail.jsp" %>
<!-- [Page specific CSS] start -->
<link rel="stylesheet" href="/static/css/admin/viewUserInfo.css">
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
              <h2 class="mb-0">회원 정보 조회</h2>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- [ page title ] end -->
    <div class="row">
      <!-- [ block1 : 회원 현황 ] start -->
      <div class="col-lg-3">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <div class="mb-4">
              <label class="form-label">개인정보:</label>
              <select class="form-select form-select-sm mb-2" id="searchType">
                <option value="1">성</option>
                <option value="2">이름</option>
                <option value="3">이메일</option>
                <option value="4">휴대폰번호</option>
              </select>
              <input class="form-control form-control-sm" type="text" placeholder="" id="searchText">
            </div>
            <div class="mb-4">
              <label class="form-label">회원등급:</label>
              <select class="form-select form-select-sm mb-2 " id="searchGrade">
              </select>
            </div>
            <div class="mb-4">
              <label class="form-label">회원유형:</label><br>
              <div class="btn-group" role="group" id="userType">
                <input type="radio" class="btn-check" id="memberTypeAll" name="memberType" value="3">
                <label class="btn btn-outline-info" for="memberTypeAll">전체</label>
                <input type="radio" class="btn-check" id="memberTypeNormal" name="memberType" value="1">
                <label class="btn btn-outline-info" for="memberTypeNormal">일반회원</label>
                <input type="radio" class="btn-check" id="memberTypeVIP" name="memberType" value="0">
                <label class="btn btn-outline-info" for="memberTypeVIP">특별회원</label>
                <input type="radio" class="btn-check" id="memberTypeBlack" name="memberType" value="2">
                <label class="btn btn-outline-info" for="memberTypeBlack">불량회원</label>
              </div>
            </div>
            <div class="mb-4">
              <label class="form-label">성별:</label><br>
              <div class="btn-group" role="group">
                <input type="radio" class="btn-check" id="genderTypeAll" name="gender" value="3">
                <label class="btn btn-outline-info" for="genderTypeAll">전체</label>
                <input type="radio" class="btn-check" id="genderTypeMale" name="gender" value="1">
                <label class="btn btn-outline-info" for="genderTypeMale">남</label>
                <input type="radio" class="btn-check" id="genderTypeFemale" name="gender" value="2">
                <label class="btn btn-outline-info" for="genderTypeFemale">여</label>
              </div>
            </div>
            <div class="mb-4">
              <label class="form-label">주문일</label>
              <div class="input-daterange input-group " id="datepicker_range">
                <input type="text" class="form-control text-left" placeholder="시작 날짜" name="range-start" >
                <input type="text" class="form-control text-end" placeholder="종료 날짜" name="range-end" >
              </div>
            </div>
            <div class="text-center">
              <button type="button" class="btn btn-primary" onclick="search()">검색</button>
            </div>
          </div>
        </div>
      </div>
      <!-- [ block1 : 회원 현황 ] end -->
      <!-- [ block2 : 최근 가입 회원 ] start -->
      <div class="col-lg-9">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <h4 class="mb-2 pt-2 ">회원 목록
              <button type="button" class="btn btn-icon btn-link-primary avtar-xs" data-bs-toggle="popover" 
              data-bs-title="회원 목록"  data-bs-placement="bottom" data-bs-html="true"
              data-bs-content="
              <ul>
                <li>삭제 시 회원의 미완료 주문 여부, 적립금 여부를 확인하며 미완료 주문이 있는 경우 삭제되지 않습니다.</li>
                <li>[자세히보기]를 체크하면 각 회원의 적립금, 예치금, 접속, 주문, 총 주문금액, 총 실결제금액을 확인할 수 있습니다.</li>
                <li>해당 기능은 100개 이하 목록에서는 바로 확인할 수 있으며, 200개 이상은 [관련 내역 보기]의 각 버튼을 통해 확인할 수 있습니다.</li>
                <li>휴면회원의 개인정보는 분리, 보관되어 쇼핑몰 관리자의 '고객관리 > 회원관리 > 휴면회원 관리'에서 별도로 조회할 수 있으며, 휴면회원이 로그인시 자동으로 휴면해제가 됩니다.</li>
                <li>일반전화 또는 스마트폰 아이콘을 클릭하면 전화상담메모 창을 띄웁니다.</li>
              </ul>">
              <i class="ti ti-info-circle"></i></button>
            </h4>
            <div class="mb-2 d-flex justify-content-between align-items-center">
              <div class="flex-grow-1">
                [총 회원수 <span class="totalResults"></span>명] 검색결과 <span class="totalResults"></span>건
                <button class="btn btn-icon btn-link-warning avtar-xs"><i class="ph-duotone ph-star"></i></button>특별관리회원
                <button class="btn btn-icon btn-link-danger avtar-xs"><i class="ph-duotone ph-warning-circle"></i></button>불량회원
              </div>
              <select class="form-select form-select-sm width-120px" id="countPerPage" onchange="setCount(this)">
                <option value="10">10개씩 보기</option>
                <option value="20">20개씩 보기</option>
                <option value="30">30개씩 보기</option>
                <option value="40">40개씩 보기</option>
                <option value="50">50개씩 보기</option>
                <option value="100">100개씩 보기</option>
                <option value="200">200개씩 보기</option>
                <option value="500">500개씩 보기</option>
                <option value="1000">1000개씩 보기</option>
              </select>
            </div>
            <div class="mb-3">
              <button type="button" class="btn btn-outline-warning btn-sm" onclick="setType(0)">특별회원 설정</button>
              <button type="button" class="btn btn-outline-secondary btn-sm" onclick="setType(2)">불량회원 설정</button>
              <button type="button" class="btn btn-outline-primary btn-sm" onclick="setType(1)">일반회원 설정</button>
              <button type="button" class="btn btn-outline-danger btn-sm" onclick="setOut()">회원 강제 탈퇴</button>
            </div>
            <div class="table-responsive" id="dataTable">
              <table class="table  table-bordered align-middle">
                <thead class="text-center">
                  <tr>
                    <th scope="col"><input type="checkbox" onclick="check_all('check', this);" class="allChk"></th>
                    <th scope="col">등록일</th>
                    <th scope="col">이름</th>
                    <th scope="col">이메일</th>
                    <th scope="col">타입</th>
                    <th scope="col">회원등급</th>
                    <th scope="col">휴대전화</th>
                    <th scope="col">성별</th>
                    <th scope="col">메일/SMS/메모</th>
                    <th scope="col">관련 내역 보기</th>
                  </tr>
                </thead>
                <tbody class="text-center " id="userList">
                </tbody>
              </table>
              <!-- [ Pagination ] start -->        
              <nav id="pagination" aria-label="Page navigation example"></nav>
              <!-- [ Pagination ] end -->
            </div>
            <div class="no-result text-center mt-5 mb-5 visually-hidden">
              검색된 회원 내역이 없습니다.
            </div>
            <div class="mb-3">
              <button type="button" class="btn btn-outline-warning btn-sm" onclick="setType(0)">특별회원 설정</button>
              <button type="button" class="btn btn-outline-secondary btn-sm" onclick="setType(2)">불량회원 설정</button>
              <button type="button" class="btn btn-outline-primary btn-sm" onclick="setType(1)">일반회원 설정</button>
              <button type="button" class="btn btn-outline-danger btn-sm" onclick="setOut()">회원 강제 탈퇴</button>
            </div>
          </div>
        </div>
      </div>
      <!-- [ block2 : done ] end -->
    </div>
  </div>
</div>
<!-- [ Main Content ] end -->
<!-- [ Modal Content ] start -->
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" id="modal">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header" >
        <h5 class="modal-title">게시글 내용 미리보기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="modal-body"></div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
<!-- [ Modal Content ] end -->
<!-- [ Modal Content ] start -->
<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="viewUserInfo">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <ul class="nav nav-tabs mb-3" id="myTab" role="tablist">
          <li class="nav-item">
            <a class="nav-link active text-uppercase" id="home-tab" data-bs-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-uppercase" id="profile-tab" data-bs-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Profile</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-uppercase" id="contact-tab" data-bs-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">Contact</a>
          </li>
        </ul>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
        <div class="tab-content " id="myTabContent">
          <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
            <p class="mb-0">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem
              Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer
              took a galley of type and scrambled it to make a type specimen book. It has survived not only
              five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.
            </p>
          </div>
          <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
            <p class="mb-0">It is a long established fact that a reader will be distracted by the readable
              content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a
              more-or-less normal distribution of letters, as opposed to using 'Content here, content here',
              making it look like readable English. Many desktop publishing packages and web page editors now
              use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many
              web sites still in their infancy.</p>
          </div>
          <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
            <p class="mb-0">There are many variations of passages of Lorem Ipsum available, but the majority
              have suffered alteration in some form, by injected humour, or words which don't look
              even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure
              there isn't anything embarrassing hidden in the middle of text.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- [ Modal Content ] end -->
<!-- [Page Specific JS] start -->
<script src="/static/assets/js/plugins/simple-datatables.js"></script>
<script src="/static/assets/js/plugins/bootstrap-datepicker.min.js"></script>
<script src="/static/js/admin/user/search.js"></script>
<script src="/static/js/admin/user/memo.js"></script>

<!-- [Page Specific JS] end -->

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>