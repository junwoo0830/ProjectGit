<script type="text/javascript" src="../library/chart.bundle.js"></script>
<div id="container" style="border: solid 1px black; width: 100%; 
height: 300px; margin-bottom: 10px;">
        <canvas id="canvas" style="margin-left: 5px;"></canvas>
    </div>

    <script type="text/javascript">
        var ChartHelper = {
            chartColors: {
                red: 'rgb(255, 99, 132)'
                , orange: 'rgb(255, 159, 64)'
                , yellow: 'rgb(255, 205, 86)'
                , green: 'rgb(75, 192, 192)'
                , blue: 'rgb(54, 162, 235)'
                , purple: 'rgb(153, 102, 255)'
                , grey: 'rgb(201, 203, 207)'
            }
        };

        var color = Chart.helpers.color;

        var data1 = null;
        var data2 = null;
        var barChartData = null;

        // todo: data setting
        data1 = ['10', '20', '30', '40', '50', '60', '70', '80'
, '90', '100', '110', '120'];
        data2 = ['120', '110', '100', '90', '80', '70', '60', '50'
, '40', '30', '20', '10'];

        barChartData = {
            labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월'
, '9월', '10월', '11월', '12월']
            , datasets: [
                {
                    label: 'DataSet1'
                    , backgroundColor: 
color(ChartHelper.chartColors.blue).alpha(0.5).rgbString()
                    , borderColor: ChartHelper.chartColors.blue
                    , borderWidth: 1
                    , data: data2
                }
                , {
                    label: 'DataSet2'
                    , backgroundColor: 
color(ChartHelper.chartColors.red).alpha(0.5).rgbString()
                    , borderColor: ChartHelper.chartColors.red
                    , borderWidth: 1
                    , data: data1
                }
            ]
        };

        var ctx = document.getElementById('canvas').getContext('2d');

        window.BarChart = new Chart(ctx, {
            type: 'bar'
// 옆으로 누운 bar 차트를 쓰실 경우 바꾸시면 됩니다.
            //type: 'horizontalBar'
            , data: barChartData
            , options: {
// responsive, maintainAspectRatio의 설정이 아래와 같이 해야
// 브라우저의 크기를 변경해도 canvas를 감싸고 있는
// div의 크기에 따라 차트가 깨지지 않고 이쁘게 출력 됩니다. 
                responsive: true   //auto size : true
                , maintainAspectRatio: false
                , legend: {
                    position: 'top'
                }
                , title: {
                    display: true
                    , text: 'Chart Title'
                }
// Bar 하나에 데이터 모두 보여줄 경우 사용
// 주석 처리 할 경우 이 예제에서는 data1, data2 각각 bar가 2개씩 나옵니다.
                //, scales: {
                //    xAxes: [
                //        { stacked: true }
                //    ]
                //    , yAxes: [
                //        { stacked: true }
                //    ]
                //}

// or bar chart 하나씩 보여줄 경우
                  , scales: {
                        yAxes: [{
                            ticks: {
// Y 축 0부터 시작
                                beginAtZero:true
// Y 축 정수로 보여주기 
// 숫자가 작거나 또는 0인 경우 등 자동으로 보여주므로 소숫점으로 나타난다
                                , callback: function (value) {
                                    if (0 === value % 1) {
                                        return value;
                                    }
                                }
                            }
                        }]
                    }
// 아래 주석 처리하여도 포인터를 바에 가져가면 수치가 나옵니다.
// 그러나 min 버젼을 link할 경우 영역에다 가져가면 나오질 않아요
// 또한 툴팁에 해당 데이터의 색도 나오지 않습니다.
// 직접 코딩 후 min 버젼으로 교체하여 테스트 해보시면 차이를 알 수 있습니다.
                // Tooltip 
                //, tooltips: {
                //    mode: 'index',
                //    intersect: false,
                //},
                //hover: {
                //    mode: 'nearest',
                //    intersect: true
                //}
            }
        });

        var colorNames = Object.keys(ChartHelper.chartColors);
    </script>