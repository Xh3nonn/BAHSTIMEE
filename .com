<html>
<head>
  <link rel="stylesheet" type="text/css" href="css/styles.css" media="screen"/>
  <title>BAHS Time</title>

<script>
function init(){
  bellSchedule();

}

function bellSchedule() {
  let d = new Date();
  let currentDayOfWeek = d.getDay();
  let currentYear = d.getYear() - 100;
  let currentMonth = d.getMonth() + 1;
  let todaysDate = currentMonth.toString() + d.getDate().toString() + currentYear.toString();

  let currentTimeIndex = d.getHours() + "" + (d.getMinutes()<10?'0':'') + d.getMinutes();
  let currentMessage = "";
  let nextMessage = "";
  let plusNextMessage = "";
  let sched = [];
  let schedTitle = "";

if (currentDayOfWeek == 0 || currentDayOfWeek == 6){
    schedTitle = "It's the WEEKEND! Enjoy!";
    sched = [
      { t: 0, msg: "School is out!" },
      { t: 1, msg: "School is out!" },
      { t: 2359, msg: "School is out!"},
    ];
    let sl = sched.length;
  }
  else {
    schedTitle = "Freshman & Sophmore Schedule";
    sched = [
            { t: 0, msg: "8:15<br />	First Bell" },
     { t: 830, msg: "1st Period <br />	 8:30 -  9:15 " },
     { t: 922, msg: "Transition    <br />	 9:15 -  9:20" },
     { t: 926, msg: "2nd Period <br />	 9:20 -  10:05 " },
     { t: 1014, msg: "Transition    <br />	 10:05 -  10:10" },
     { t: 1018, msg: "3rd Period <br />	 10:10 -  10:55 " },
     { t: 1106, msg: "Transition    <br />	 10:55 -  11:00" },
     { t: 1110, msg: "4th Period/Lunch <br />	 11:00 -  11:30 " },
     { t: 1158, msg: "Transition    <br />	 11:30 -  11:35" },
     { t: 1202, msg: "5th Period <br />	 11:35 -  12:20 " },
     { t: 1232, msg: "Transition    <br />	 12:20 -  12:25" },
     { t: 1236, msg: "6th Period/Advisory <br />	 12:25 -  12:50 " },
     { t: 1324, msg: "Transition    <br />	 12:50 -  12:55" },
     { t: 1328, msg: "7th Period <br />	 12:55 -  1:40 " },
     { t: 1416, msg: "Transition    <br />	 1:40 -  1:45" },
     { t: 1420, msg: "8th Period <br />	 1:45 -  2:30 " },
     { t: 1508, msg: "Transition    <br />	 2:30 -  2:35" },
     { t: 1512, msg: "9th Period <br />	 2:35 -  3:20 " },
     { t: 1508, msg: "Transition    <br />	 3:20 -  3:25" },
     { t: 1512, msg: "9th Period <br />	 3:25 -  4:10 " },
     { t: 1600, msg: "School's Out!" },
     { t: 2400, msg: "clock will reset"},

    ];
    let sl = sched.length;
  }

  document.getElementById("schedTitle").innerHTML = schedTitle;
  
  let sl = sched.length;
  for (let i = 0; i < sl; i++) {
    if (currentTimeIndex >= sched[i].t) {
      currentMessage = sched[i].msg;
      document.getElementById("message").innerHTML = currentMessage;
      nextMessage = "";
      plusNextMessage = "";

      let ni = i+1; let nii = i+2;
      if (ni < sl && nii < sl) {
          nextMessage = sched[ni].msg;
          document.getElementById("next-message").innerHTML = "Next Up...<br />" + nextMessage;
          plusNextMessage = sched[nii].msg;
          document.getElementById("plus-next-message").innerHTML = "Then...<br />" + plusNextMessage;
      }
    var countDown = (Math.trunc(sched[ni].t/100) * 60 + sched[ni].t % 100) - (Math.trunc(currentTimeIndex/100) * 60 + currentTimeIndex % 100);
    var countDownSeconds = 59 - d.getSeconds();
    }
  }

  if(countDown < 5){
    countDown = countDown - 1;
    document.getElementById("countdown").innerHTML = "<span style='color:red'>" + countDown + ":" + (countDownSeconds<10?'0':'') + countDownSeconds;
  }
  else if(countDown > 60) {
    document.getElementById("countdown").innerHTML =  "<span style='color:#0044aa'>" + Math.floor(countDown/60) + " hours " +  countDown%60 + " minutes </style>";
  }
  else {
    document.getElementById("countdown").innerHTML =  "<span style='color:#0044aa'>Minutes Remaining: </style>" + countDown;
  }

  document.getElementById("clock").innerHTML = d;

  setTimeout(function () { bellSchedule() }, 1000);
}


</script>
</head>

<body onload="init()">
  <noscript>
    You will need JavaScript to use this site.
  </noscript>

<div id="wrapper">

  <div id="header">
    <p class="title">
      <img src="images/logo.png" class="titleImg"/>
      BAMS <span style="color:darkred;">Time</span>
      <img src="images/logo.png" class="titleImg" />
    </p>
  </div>

  <div id="content">

    <p id="clock"></p>
    <p id="schedTitle"></p>

    <div id="schedulebox">
      <h1>
      <p id="message"></p>
      <p id="countdown"></p>
      <br />
      <p id="next-message"></p>
      <br />
      <p id="plus-next-message"></p>
      <p><br /></p>
      <p id="studentMessage"><br />LINKS:<br /><br /></p>
      
      <p id="studentMessage"><a href="https://clock.school/bams/8.html" target="_self">8th Grade Schedule</a><br /><br /></p>
      <p id="studentMessage"><a href="https://hac.yisd.net/HomeAccess/Account/LogOn?ReturnUrl=%2fHomeAccess" target="_blank">HAC Logon</a><br /><br /><p>
   </div>
    </div>




</div>
</body>
</html>
