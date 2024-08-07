import { CommonConstants } from '../../constants/CommonConstants'
import RecordItemModel from '../../model/RecordItemModel'

interface GeneratedTypeLiteralInterface_1 {
  label: string;
  value: number;
}

@Component
export default struct ItemCard {
  @Prop amount: number
  @Link item: RecordItemModel

  build() {
    Column({ space: CommonConstants.SPACE_8 }) {
      Image(this.item.image).width(150)
      Row() {
        Text(this.item.name).fontWeight(CommonConstants.FONT_WEIGHT_600)
      }
      .backgroundColor($r('app.color.lightest_primary_color'))
      .padding({ top: 5, bottom: 5, left: 12, right: 12 })

      Divider().width(CommonConstants.THOUSANDTH_940).opacity(0.6)
      Row({ space: CommonConstants.SPACE_8 }) {
        this.NutrientInfo({label:'热量(千卡)', value: this.item.calorie})
        if(this.item.id<10000){
          this.NutrientInfo({label:'碳水(克)', value: this.item.carbon})
          this.NutrientInfo({label:'蛋白质(克)', value: this.item.protein})
          this.NutrientInfo({label:'脂肪(克)', value: this.item.fat})
        }
      }

      Divider().width(CommonConstants.THOUSANDTH_940).opacity(0.6)
      Row() {
        Column({ space: CommonConstants.SPACE_4 }) {
          Text(this.amount.toFixed(1))
            .fontSize(50).fontColor($r('app.color.primary_color'))
            .fontWeight(CommonConstants.FONT_WEIGHT_600)
          Divider().color($r('app.color.primary_color'))
        }.width(150)

        Text(this.item.unit)
          .fontWeight(CommonConstants.FONT_WEIGHT_600)
          .fontColor($r('app.color.light_gray'))
      }
    }
  }

  @Builder NutrientInfo($$: GeneratedTypeLiteralInterface_1) {
    Column({ space: CommonConstants.SPACE_8 }) {
      Text($$.label).fontSize(14).fontColor($r('app.color.light_gray'))
      Text(($$.value * this.amount).toFixed(1)).fontSize(18).fontWeight(CommonConstants.FONT_WEIGHT_700)
    }
  }
}