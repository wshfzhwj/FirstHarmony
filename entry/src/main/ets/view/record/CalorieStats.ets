import { CommonConstants } from '../../constants/CommonConstants'

@Component
export default struct CalorieStats {
  @Prop intake: number
  @Prop expend: number
  recommend: number = CommonConstants.RECOMMEND_CALORIE

  remainCalorie() {
    return this.recommend - this.intake + this.expend
  }

  build() {
    Row({ space: CommonConstants.SPACE_6 }) {
      this.StatusBuilder(new CalorieStatsInfo('饮食摄入', this.intake))
      Stack() {
        Progress({
          value: this.intake,
          total: this.recommend,
          type: ProgressType.Ring
        }).width(120)
          .style({strokeWidth:CommonConstants.DEFAULT_10})
          .color($r('app.color.primary_color'))
        this.StatusBuilder(new CalorieStatsInfo('还可以吃', this.remainCalorie(),`推荐${this.recommend}`))
      }

      this.StatusBuilder(new CalorieStatsInfo('运动消耗', this.expend))
    }.width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })
  }

  @Builder StatusBuilder($$:CalorieStatsInfo) {
    Column({ space: CommonConstants.SPACE_6 }) {
      Text($$.label)
        .fontColor($r('app.color.gray'))
        .fontWeight(CommonConstants.FONT_WEIGHT_600)
      Text($$.value.toFixed(0))
        .fontSize(20)
        .fontWeight(CommonConstants.FONT_WEIGHT_700)
      if ($$.tips) {
        Text($$.tips)
          .fontSize(12)
          .fontColor($r('app.color.light_gray'))
          .fontWeight(CommonConstants.FONT_WEIGHT_700)
      }

    }
  }

}

class CalorieStatsInfo{
  label: string
  value: number
  tips?: string

  constructor(label: string, value: number, tips?:string) {
    this.label = label
    this.value = value
    this.tips = tips
  }
}