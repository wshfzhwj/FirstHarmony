import router from '@ohos.router'
import { CommonConstants } from '../../constants/CommonConstants'
import RecordItem from '../../model/RecordItemModel'
import ItemCard from '../../view/item/ItemCard'
import ItemList from '../../view/item/ItemList'
import ItemPanelHeader from '../../view/item/ItemPanelHeader'
import NumberKeyboard from '../../view/item/NumberKeyborad'
import { RecordTypeEnum, RecordTypes } from '../../model/RecordType'
import RecordType from '../../model/RecordTypeModel'
import RecordService from '../../service/RecordService'
import RecordTypeModel from '../../model/RecordTypeModel'
import RecordItemModel from '../../model/RecordItemModel'

class InfoTmp {
  type: RecordTypeModel = new RecordTypeModel(0, $r("app.string.breakfast"), $r("app.media.ic_breakfast"), 423, 592)
}

@Entry
@Component
struct ItemIndex {
  @State amount: number = 1
  @State value: string = ''
  @State showPanel: boolean = false
  @State item: RecordItem | null = null
  @State type: RecordTypeModel = RecordTypes[0]
  @State isFood: boolean = true

  onPanelShow(item: RecordItemModel) {
    console.log('ItemIndex', 'onPanelShow')
    this.showPanel = true
    this.value = ''
    this.amount = 1
    this.item = item
    console.log('ItemIndex', 'onPanelShow showPanel = ' + this.showPanel)
  }

  @Builder
  mySheet() {
    Column() {
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
            RecordService.insert(this.type.id, this.item!!.id, this.amount).then(() => {
              this.showPanel = false
            })
          })
      }.margin({ top: 10 })
    }.width('100%')
    .height('100%')
    .backgroundColor(Color.White)

  }

  onPageShow() {
    let params = router.getParams() as InfoTmp
    this.type = params.type
    this.isFood = this.type.id !== RecordTypeEnum.WORKOUT
  }

  build() {
    Column() {
      //1.头部导航
      this.Header()
      //2.列表
      ItemList({
        showPanelFunc: (item: RecordItemModel) => {
          this.onPanelShow(item)
        }, isFood: this.isFood
      })
        .layoutWeight(1)
        .bindSheet(this.showPanel, this.mySheet(), {
          dragBar: false,
          backgroundColor: (Color.White),
          maskColor: $r('app.color.light_gray')
        })
    }
    .width('100%')
    .height('100%')

  }

  @Builder
  Header() {
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