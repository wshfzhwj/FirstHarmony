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
      this.StatusBuilder({label: '饮食摄入', value: this.intake})
      Stack() {
        Progress({
          value: this.intake,
          total: this.recommend,
          type: ProgressType.Ring
        }).width(120)
          .style({strokeWidth:CommonConstants.DEFAULT_10})
          .color($r('app.color.primary_color'))
        this.StatusBuilder({label: '还可以吃', value: this.remainCalorie(), tips: `推荐${this.recommend}`})
      }

      this.StatusBuilder({label: '运动消耗', value: this.expend})
    }.width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })
  }

  @Builder StatusBuilder($$:{label: string, value: number, tips?: string}) {
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