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
      { t: 815, msg: "First Bell <br />	 8:15 -  8:30" },
     { t: 830, msg: "1st Period <br />	 8:30 -  9:15 " },
     { t: 915, msg: "Transition    <br />	 9:15 -  9:20" },
     { t: 920, msg: "2nd Period <br />	 9:20 -  10:05 " },
     { t: 1005, msg: "Transition    <br />	 10:05 -  10:10" },
     { t: 1010, msg: "3rd Period <br />	 10:10 -  10:55 " },
     { t: 1055, msg: "Transition    <br />	 10:55 -  11:00" },
     { t: 1100, msg: "4th Period/Lunch <br />	 11:00 -  11:30 " },
     { t: 1130, msg: "Transition    <br />	 11:30 -  11:35" },
     { t: 1135, msg: "5th Period <br />	 11:35 -  12:20 " },
     { t: 1220, msg: "Transition    <br />	 12:20 -  12:25" },
     { t: 1225, msg: "6th Period <br />	 12:25 -  1:10 " },
     { t: 1310, msg: "Transition    <br />	 1:10 -  1:15" },
     { t: 1315, msg: "7th Period/Advisory <br />	 1:15 -  1:40 " },
     { t: 1340, msg: "Transition    <br />	 1:40 -  1:45" },
     { t: 1345, msg: "8th Period <br />	 1:45 -  2:30 " },
     { t: 1430, msg: "Transition    <br />	 2:30 -  2:35" },
     { t: 1435, msg: "9th Period <br />	 2:35 -  3:20 " },
     { t: 1520, msg: "Transition    <br />	 3:20 -  3:25" },
     { t: 1525, msg: "9th Period <br />	 3:25 -  4:10 " },
     { t: 1610, msg: "School's Out!" },
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
    document.getElementById("countdown").innerHTML =  "<span style='color:#FF000D'>" + Math.floor(countDown/60) + " hours " +  countDown%60 + " minutes </style>";
  }
  else {
    document.getElementById("countdown").innerHTML =  "<span style='color:#FF000D'>Minutes Remaining: </style>" + countDown;
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
      <img src="https://www.simpleimageresizer.com/_uploads/photos/5ce1c2a6/Bel_Airhigh_school_logos-02_8.png" class="titleImg"/>
      BAHS <span style="color:darkred;">Time</span>
      <img src="https://www.simpleimageresizer.com/_uploads/photos/5ce1c2a6/Bel_Airhigh_school_logos-02_8.png" class="titleImg" />
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
      <p id="studentMessage"><a href="https://hac.yisd.net/HomeAccess/Account/LogOn?ReturnUrl=%2fHomeAccess" target="_blank">HAC Login</a><br /><br /><p>
   </div>
    </div>




</div>
</body>
</html>
