# StyxDate
*根据数据生成Date*

```let date = Date(year: 1998, month: 2, day: 18, hour: 15, minute: 58, second: 56)
let date2 = Date(year: 1990, month: 2, day: 18)```

// 快速获取日期

`let today = Date.today()`<br>
`let tomorrow = Date.tomorrow()`<br>
`let yesterday = Date.yesterday()`

// 日期相加减 已经考虑大小月 闰月等问题

`let now = Date()`<br>
`let oneMonthLater = now + 1.month`
// 或者<br>
`let twoYearLater = 2.years.later`

// date -> string

`let threeMinutsAgo = 3.minuts.ago`<br>
`let dateString = threeMinutsAgo?.string("dd:mm:ss")`<br>
`let dateString1 = threeMinutsAgo?.dateString(in: .full)`<br>
`let dateString2 = threeMinutsAgo?.timeString(in: .short)`
