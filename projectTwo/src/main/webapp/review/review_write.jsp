<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@page import="xyz.nailro.dao.OrderDAO"%>
<%@page import="xyz.nailro.dto.OrderDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@include file="/security/login_check.jspf"%>
<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
<%
	int productNum = Integer.parseInt(request.getParameter("productNum"));
	int orderNum = Integer.parseInt(request.getParameter("orderNum"));
%>
<style type="text/css">
table {
    margin: 0 auto;
}

th {
    width: 100px;
    font-weight: bold; 
    padding: 10px;	
}

td {
    text-align: left;
    padding: 10px;	
}
#reviewForm {
	height: 500px;
}


#subjectForm {
    width: 382px;
}

#review_subject {
    text-align: center;
    font-size: 40px;
}

.button-group {
    display: center;
}

#saveBtn, #resetBtn {
    font-size: 20px;
    border-radius: 5px;
    background-color: #FFDCE1;
    margin-left: 10px;
    padding: 10px 15px;
    width: 120px;
    border: 1px solid white;
}

.star-rating {
    font-size: 30px;
    color: black;
    cursor: pointer;
}


#review_subject {
    text-align: center;
}

#starmessage {
	font-size: 0.5em;
}

</style>
<h1 id="review_subject">REVIEW</h1>
<form action="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_writer_action"
    method="post" enctype="multipart/form-data" id="reviewForm">
   <input type="hidden" id="orderNum" name="orderNum" value="<%=orderNum%>">
   <input type="hidden" id="productNum" name="productNum" value="<%=productNum%>">
    <table>
        <tr>
            <td>별점:</td>
            <td>
                <div class="star-rating">
                    <span class="star" onclick="setRating(1)">☆</span>
                    <span class="star" onclick="setRating(2)">☆</span>
                    <span class="star" onclick="setRating(3)">☆</span>
                    <span class="star" onclick="setRating(4)">☆</span>
                    <span class="star" onclick="setRating(5)">☆</span>
                	<div id="starmessage" style="color: red;">별점을 꼭 체크해주세요!</div>
                </div> 
                <input type="hidden" name="review_rating" id="ratingValue">
            </td>
        </tr>
        <tr>
            <td>제목:</td>
            <td><input type="text" name="review_subject" id="subjectForm"
                required></td>
        </tr>
        <tr>
            <td>내용:</td>
            <td><textarea name="review_content" rows="5" cols="50" required></textarea></td>
        </tr>
        <tr>
            <td>이미지:</td>
            <td><input type="file" name="review_image"></td>
        </tr>
        <tr>
            <th colspan="2" class="button-group">                
                <button type="submit" id="saveBtn">글저장</button>
                <button type="reset" id="resetBtn">다시쓰기</button>
            </th>
        </tr>
    </table> 
</form>
<script type="text/javascript">
$("#subjectForm").focus();

// 별점을 설정하는 함수
function setRating(rating) {
	const stars = document.querySelectorAll('.star');
	let starsText = '';
	for (let i = 0; i < rating; i++) {
    	starsText += '★';
	}
	// ★ 문자열을 숨겨진 필드에 저장
	document.getElementById('ratingValue').value = starsText;

	// 별 표시 업데이트
	stars.forEach((star, index) => {
	    if (index < rating) {
	        star.textContent = '★'; 
	        star.classList.add('checked');
	    } else {
	        star.textContent = '☆';
	        star.classList.remove('checked');
	    }
	});
}

// 페이지 로드 시 별점 초기화
document.addEventListener('DOMContentLoaded', function () {
    const currentRating = document.getElementById('ratingValue').value.length; // ★ 문자열의 길이를 통해 현재 별점 계산
    setRating(currentRating);
});

// 별 클릭 이벤트 처리
document.querySelectorAll('.star').forEach((star, index) => {
    star.addEventListener('click', () => {
        setRating(index + 1); // 클릭한 별에 해당하는 별점 설정
    });
});

</script>
