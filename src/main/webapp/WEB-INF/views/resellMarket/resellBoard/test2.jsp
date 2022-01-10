<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<title>Insert title here</title>
</head>
<body>
    <h1>내사이트임 ㅎㅇ</h1>
    <p></p>
    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script>
        $.ajax({
            method: "get",
            url: "https://dapi.kakao.com/v3/search/book?target=title",
            data: { query:"시간은 이야기가 된다" },
            headers : {Authorization: "KakaoAK 1a5706e61206f647085802ffe2b38897"}
        })
            .done(function (msg) {
                console.log(msg.documents[0].title);
                console.log(msg.documents[0].thumbnail);
                $( "p" ).append( "<strong>"+msg.documents[0].title+"</strong>" );
                $( "p" ).append( "<img src='"+msg.documents[0].thumbnail+"<'/>" );
            });
        
    </script>
<h1>여기나오늬?</h1>
<div style="">
<canvas id="tetrisCanvas" width="200" height="400"></canvas>
</div>


	<table>
        <tr>
            <th>이름</th>
            <td><input type="text" name="user_name"></td>
        </tr>
        <tr>
            <th>주소</th>
            <td><input type="text" id="address_kakao" name="address" readonly /></td>
        </tr>
        <tr>
            <th>상세 주소</th>
            <td><input type="text" name="address_detail" /></td>
        </tr>
    </table>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</body>

<!-- Modernizer api import-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>
    <script>
      // geolocation api 가 지원되는 브라우저 인지 확인
      if (Modernizr.geolocation) {
        // 현재 위치 가져오기
        navigator.geolocation.getCurrentPosition(
          // 성공이면 위치를 찍어준다.
          function (pos) {
            console.log(pos.coords.latitude);
            console.log(pos.coords.longitude);
          },
          function () {}
        );
      }
    </script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address_kakao").value = data.address; // 주소 넣기
                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>
<script>
//  control with keyboard, block color
var canvas = document.getElementById('tetrisCanvas');
var ctx = canvas.getContext('2d');

var shapes = [
            [ 0x4640, 0x0E40, 0x4C40, 0x4E00 ], // 'T'
            [ 0x8C40, 0x6C00, 0x8C40, 0x6C00 ], // 'S'
            [ 0x4C80, 0xC600, 0x4C80, 0xC600 ], // 'Z'
            [ 0x4444, 0x0F00, 0x4444, 0x0F00 ], // 'I'
            [ 0x44C0, 0x8E00, 0xC880, 0xE200 ], // 'J'
            [ 0x88C0, 0xE800, 0xC440, 0x2E00 ], // 'L'
            [ 0xCC00, 0xCC00, 0xCC00, 0xCC00 ]  // 'O'
];


function getNextShape() {
    curShapeType = Math.floor((Math.random() * 7));
    curRotation = 0;
    return shapes[curShapeType][curRotation]
}

var ROW_CNT = 20;
var COL_CNT = 10;
var KEY = { ESC: 27, SPACE: 32, LEFT: 37, UP: 38, RIGHT: 39, DOWN: 40 };
var shapeColor = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"];

var curShapeType = 0, curRotation = 0, curShape = getNextShape() ;
var sPos = {x: (COL_CNT-4) / 2, y:0};
var gamePanel = [];
for (var y = 0; y < ROW_CNT; y++) {
    gamePanel[y] = [];
    for (var x = 0; x < COL_CNT; x++) {
        gamePanel[y][x] = 0;
    }
} 

var requestId = 0, isPlaying=true;
var dt = 0, step = 0.6, completedRow = 0;;
var last = now = timestamp();

function timestamp() { return new Date().getTime(); }
    
function frame() {
    now = timestamp();
    update(Math.min(1, (now - last) / 1000.0)); 
    last = now;
    if (isPlaying){
        requestId = requestAFrame(frame);
    } else {
        window.cancelAFrame(requestId);   
    }
}

function update(idt) {
    dt = dt + idt;
    if (dt > step) {
        dt = dt - step;
        playingTetris();
    }
}

window.onload = function(){
    requestId = window.requestAFrame(frame);
}

window.requestAFrame = (function () {
    return window.requestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            window.oRequestAnimationFrame ||
            function (callback) {
                return window.setTimeout(callback, 1000 / 60); // shoot for 60 fps
            };
})();

window.cancelAFrame = (function () {
    return window.cancelAnimationFrame ||
            window.webkitCancelAnimationFrame ||
            window.mozCancelAnimationFrame ||
            window.oCancelAnimationFrame ||
            function (id) {
                window.clearTimeout(id);
            };
})();

function playingTetris() {
    if ( intersects(sPos.y + 1, sPos.x)) {
        for (var i = 0; i < 4; i++)
            for (var j = 0; j < 4; j++)
                if ((curShape & (0x8000 >> (i * 4 + j))) && gamePanel[sPos.y+i]) {
                    gamePanel[sPos.y+i][sPos.x+j] = curShapeType+1;
                }
        
        curShape = getNextShape();        
        sPos = {x: (COL_CNT-4) / 2, y:0};
        if (intersects(sPos.y, sPos.x)) {
            isPlaying = false;
            alert("Game Over");
        }
        gamePanel = removeRow();
    } else {
        sPos.y++;
    }
    draw();
}    

function intersects(y, x) {
    for (var i = 0; i < 4; i++)
        for (var j = 0; j < 4; j++)
            if (curShape & (0x8000 >> (i * 4 + j)))
                if (y+i >= ROW_CNT || x+j < 0 || x+j >= 10 || gamePanel[y+i][x+j])
                    return true;
    return false;
}

function draw() {
    ctx.fillStyle = 'white';
    ctx.fillRect(0, 0, 200, 400);
    ctx.rect(0, 0, 200, 400);
    ctx.strokeStyle="blue";
    ctx.stroke(); 
    
    ctx.fillStyle = 'black';
    for (var y = 0; y < gamePanel.length; y++) {
        for (var x = 0; x < gamePanel[y].length; x++) {
            if (gamePanel[y][x]) {
                ctx.fillStyle = shapeColor[gamePanel[y][x]-1];
                ctx.fillRect(x * 20, y * 20, 19, 19);
            }
        }
    }
    
    ctx.fillStyle = shapeColor[curShapeType];
    for (var y = 0; y < 4; y++) {
        for (var x = 0; x < 4; x++) {
            if (curShape & (0x8000 >> (y * 4 + x))) {
                ctx.fillRect((sPos.x+x) * 20, (sPos.y+y) * 20, 19, 19);
            }
        }
    }
}

function moveShape(value) {
    if ( !intersects(sPos.y, sPos.x+value)) {
        sPos.x += value;
        draw();
    }
}

function dropShape() {
    for (var y=sPos.y; y<ROW_CNT; y++) {
        if ( !intersects(sPos.y+1, sPos.x)) {
            sPos.y++;
            draw();
        } else {
            break;
        }
    }
}

function rotateShape() {
    curRotation = (curRotation + 1) % 4;;
    curShape = shapes[curShapeType][curRotation]
    draw();
}

function removeRow() {
    var newRows = [];
    var k = ROW_CNT;
    var chkReCalc = false;
    for (var y = ROW_CNT-1; y>=0; y--) {
        for (var x = 0; x < COL_CNT; x++) {
            if (!gamePanel[y][x]) {
                newRows[--k] = gamePanel[y].slice();
                break;
            }
        }
    }
    for (var y = 0; y < k; y++) {
        newRows[y] = [];
        completedRow++;
        chkReCalc = true;
        for (var x = 0; x < COL_CNT; x++)
            newRows[y][x] = 0;
    }
    if (chkReCalc) {
        step = Math.max(0.1, 0.6 - (0.5*completedRow));
    }
    
    return newRows;
}

function keydown(ev) {
    var handled = false;
    switch(ev.keyCode) {
        case KEY.LEFT:   moveShape(-1); handled = true; break;
        case KEY.RIGHT:  moveShape( 1); handled = true; break;
        case KEY.UP:     rotateShape(); handled = true; break;
        case KEY.DOWN:   dropShape();      handled = true; break;
        case KEY.ESC:    window.cancelAFrame(requestId);; handled = true; break;
    }

    if (handled) {
        ev.preventDefault();
    }
}
    
document.addEventListener('keydown', keydown, false);

</script>


</html>