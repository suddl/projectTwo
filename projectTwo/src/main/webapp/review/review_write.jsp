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
.checked {
            color: pink;
        }

</style>
<h1 id="review_subject">REVIEW</h1>
<form action="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_writer_action"
    method="post" enctype="multipart/form-data" id="reviewForm">
   <input type="hidden" id="orderNum" name="orderNum" value="<%=orderNum%>">
   <input type="hidden" id="productNum" name="productNum" value="<%=productNum%>">
    <table>
        <tr>
            <th>별점:</th>
            <td>
                <div class="star-rating">
                    <span class="star" onclick="setRating(1)">☆</span>
                    <span class="star" onclick="setRating(2)">☆</span>
                    <span class="star" onclick="setRating(3)">☆</span>
                    <span class="star" onclick="setRating(4)">☆</span>
                    <span class="star" onclick="setRating(5)">☆</span>
                	<div id="starmessage" style="color: red;">별점을 체크하셔야 리뷰등록이 가능합니다!</div>
                </div> 
                <input type="hidden" name="review_rating" id="ratingValue">
            </td>
        </tr>
        <tr>
            <th>제목:</th>
            <td><input type="text" name="review_subject" id="subjectForm"
                required></td>
        </tr>
        <tr>
            <th>내용:</th>
            <td><textarea name="review_content" rows="5" cols="50" required></textarea></td>
        </tr>
        <tr>
            <th>이미지:</th>
            <td><input type="file" name="review_image"></td>
        </tr>
        <tr>
            <th colspan="2" class="button-group">                
                <button type="submit" id="saveBtn" disabled>글저장</button>
                <button type="reset" id="resetBtn">다시쓰기</button>
            </th>
        </tr>
    </table> 
</form>
<script type="text/javascript">
$("#subjectForm").focus();

 //별점작성
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

    //별점선택되면버튼 실행
    const saveBtn = document.getElementById('saveBtn');
    if (rating > 0) {
        saveBtn.disabled = false; 
        document.getElementById('starmessage').style.display = 'none'; // 메시지 숨김
    } else {
        saveBtn.disabled = true; //버튼 비활성화
        document.getElementById('starmessage').style.display = 'block'; // 메시지 표시
    }
}

// 페이지 로드 시 별점 초기화 및 별점 선택 이벤트 설정
document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.star').forEach((star, index) => {
        star.addEventListener('click', () => {
            setRating(index + 1); // 클릭한 별에 해당하는 별점 설정
        });
    });
});



</script>
