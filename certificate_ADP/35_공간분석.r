
#===============================================================================================================
# 공간분석
# Google Vis : 구글에서 지원하는 다양한 그래프
# R 그래프보다 보기 좋고 모션 그래프도 지원
#===============================================================================================================

install.packages("googleVis")
library(googleVis)

# 1. Motion Chart ----------------------------------------------------------------------------------------------

data(Fruits)
head(Fruits)
#     Fruit Year Location Sales Expenses Profit       Date
# 1  Apples 2008     West    98       78     20 2008-12-31
# 2  Apples 2009     West   111       79     32 2009-12-31
# 3  Apples 2010     West    89       76     13 2010-12-31
# 4 Oranges 2008     East    96       81     15 2008-12-31
# 5 Bananas 2008     East    85       76      9 2008-12-31
# 6 Oranges 2009     East    93       80     13 2009-12-31

m1 <- gvisMotionChart(Fruits, idvar="Fruit", timevar="Year")
plot(m1)
# Warning
# Flash charts are no longer supported by most browsers.
# An alternative is plotly::ggplotly.
# For more see https://plotly.com/r/animations/#mulitple-trace-animations
# -> 출력 안됨 : End Flash support

# 2. Geo Chart -------------------------------------------------------------------------------------------------
# 사용법 : gvisGeoChart(data, locationvar="", colorvar="", sizevar="", hovervar="", options=list(), chartid)

data(Exports)
head(Exports)
#         Country Profit Online
# 1       Germany      3   TRUE
# 2        Brazil      4  FALSE
# 3 United States      5   TRUE
# 4        France      4   TRUE
# 5       Hungary      3  FALSE
# 6         India      2   TRUE

### 1. 전 세계 국가별 수출, 수익 크기
g1 <- gvisGeoChart(Exports, locationvar='Country', colorvar='Profit')
plot(g1)

### 2. 유럽 국가별 수익 크기
# 유럽 지역으로 한정하여, 수익 크기를 색상으로 구분
g2 <- gvisGeoChart(Exports, "Country", "Profit", options=list(region="150"))
plot(g2)

### 3. 미국의 주별 문맹률
require(datasets)
states <- data.frame(state.name, state.x77)
head(states)
#            state.name Population Income Illiteracy Life.Exp Murder HS.Grad Frost   Area
# Alabama       Alabama       3615   3624        2.1    69.05   15.1    41.3    20  50708
# Alaska         Alaska        365   6315        1.5    69.31   11.3    66.7   152 566432
# Arizona       Arizona       2212   4530        1.8    70.55    7.8    58.1    15 113417
# Arkansas     Arkansas       2110   3378        1.9    70.66   10.1    39.9    65  51945
# California California      21198   5114        1.1    71.71   10.3    62.6    20 156361
# Colorado     Colorado       2541   4884        0.7    72.06    6.8    63.9   166 103766

# option 설정
# resolution : 미국 주별 문맹률 정보가 나타나도록 해상도 수준 지정
g3 <- gvisGeoChart(states, "state.name", "Illiteracy",
                   options=list(region="US", displayMode="region", resolution="provinces",
                                width=600, height=400))
plot(g3)

### 4. 속도 표시
# Andrew : 허리케인과 관련된 위치 및 속도 정보 dataset

# 1) 허리케인 경로
# 위치별 속도를 색상으로 표시
g5 <- gvisGeoChart(Andrew, "LatLong", colorvar='Speed_kt', options=list(region="US"))
plot(g5)

# 2) 허리케인 경로
# 위치별 속도를 원 크기로 표시
g6 <- gvisGeoChart(Andrew, "LatLong", sizevar="Speed_kt", colorvar="Pressure_mb", options=list(region="US"))
plot(g6)

### 5. 깊이 표시
# Quakes : 지진 dataset

require(stats)
data(quakes)
head(quakes)
#      lat   long depth mag stations
# 1 -20.42 181.62   562 4.8       41
# 2 -20.62 181.03   650 4.2       15
# 3 -26.00 184.10    42 5.4       43
# 4 -17.97 181.66   626 4.1       19
# 5 -20.42 181.96   649 4.0       11
# 6 -19.68 184.31   195 4.0       12

quakes$latlong <- paste(quakes$lat, quakes$long, sep=":")
head(quakes$latlong)

# 지진 깊이와 진도
g7 <- gvisGeoChart(quakes, "latlong", "depth", "mag",
                   options=list(displayMode="Markers", region="009",
                                colorAxis="{colors:['red','grey']}",
                                backgroundColor="lightblue"))
plot(g7)

