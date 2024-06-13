import router from '@ohos.router'
import { CommonConstants } from '../../constants/CommonConstants'
import RecordItem from '../../viewmodel/RecordItem'
import ItemCard from '../../view/item/ItemCard'
import ItemList from '../../view/item/ItemList'
import ItemPanelHeader from '../../view/item/ItemPanelHeader'
import NumberKeyboard from '../../view/item/NumberKeyborad'
import { RecordTypeEnum, RecordTypes } from '../../model/RecordTypeModel'
import RecordType from '../../viewmodel/RecordType'
import RecordService from '../../service/RecordService'

@Entry
@Component
struct ItemIndex {
  @State amount: number = 1
  @State value: string = ''
  @State showPanel: boolean = false
  @State item: RecordItem = null
  @State type: RecordType = RecordTypes[0]
  @State isFood: boolean = true

  onPanelShow(item: RecordItem) {
    this.showPanel = true
    this.value = ''
    this.amount = 1
    this.item = item
  }

  onPageShow() {
    let params: any = router.getParams()
    this.type = params.type
    this.isFood = this.type.id !== RecordTypeEnum.WORKOUT
  }

  build() {
    Column() {
      //1.头部导航
      this.Header()
      //2.列表
      ItemList({ showPanel: this.onPanelShow.bind(this), isFood: this.isFood })
        .layoutWeight(1)
      //底部面板
      Panel(this.showPanel) {
        ItemPanelHeader()
        if (this.item) {
          ItemCard({ amount: this.amount, item: $item })
        }
        NumberKeyboard({ amount: $amount, value: $value })
        Row({ space: CommonConstants.SPACE_8 }) {
          Button('取消')
            .width(120)
            .backgroundColor($r('app.color.light_gray'))
            .type(ButtonType.Normal)
            .borderRadius(6)
            .onClick(() => this.showPanel = false)
          Button('提交')
            .width(120)
            .backgroundColor($r('app.color.primary_color'))
            .type(ButtonType.Normal)
            .borderRadius(6)
            .onClick(() => {
              RecordService.insert(this.type.id, this.item.id, this.amount).then(() => {
                this.showPanel = false
              })
            })
        }.margin({ top: 10 })
      }
      .mode(PanelMode.Full)
      .dragBar(false)
      .backgroundMask($r('app.color.light_gray'))
      .backgroundColor(Color.White)
      //键盘

    }
    .width('100%')
    .height('100%')
  }

  @Builder Header() {
    Row() {
      Image($r('app.media.ic_public_back'))
        .width(24)
        .onClick(() => router.back())
      Blank()
      Text(this.type.name).fontSize(18).fontWeight(CommonConstants.FONT_WEIGHT_600)
    }
    .width(CommonConstants.THOUSANDTH_940)
    .height(32)
  }
}