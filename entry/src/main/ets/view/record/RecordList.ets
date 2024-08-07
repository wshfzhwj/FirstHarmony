import router from '@ohos.router'
import { CommonConstants } from '../../constants/CommonConstants'
import RecordService from '../../service/RecordService'
import GroupInfo from '../../model/GroupInfoModel'
import RecordType from '../../model/RecordTypeModel'
import RecordVO from '../../model/RecordModel'
import RecordTypeModel from '../../model/RecordTypeModel'
import RecordModel from '../../model/RecordModel'

@Extend(Text) function grayText() {
  .fontSize(14)
  .fontColor($r('app.color.light_gray'))
}

@Component
export default struct RecordList {
  @Consume
  @Watch('handleRecordsChange')
  records: RecordVO[]
  @State groups: GroupInfo<RecordType, RecordVO>[] = []

  handleRecordsChange() {
    this.groups = RecordService.calculateGroupInfo(this.records)
  }

  build() {
    List({ space: CommonConstants.SPACE_10 }) {
      ForEach(this.groups, (group: GroupInfo<RecordTypeModel, RecordModel>) => {
        ListItem() {
          Column() {
            //分组标题
            Row({ space: CommonConstants.SPACE_4 }) {
              Image(group.type.icon).width(24)
              Text(group.type.name).fontSize(18).fontWeight(CommonConstants.FONT_WEIGHT_700)
              Text(`建议${group.type.min}~${group.type.max}`).grayText()
              Blank()
              Text(group.calorie.toFixed(0)).fontSize(14).fontColor($r('app.color.primary_color'))
              Text('千卡').grayText()
              Image($r('app.media.ic_public_add_norm_filled'))
                .width(20)
                .fillColor($r('app.color.primary_color'))
            }.width('100%')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/healthy/ItemIndex',
                params: {
                  type: group.type
                }
              })
            })
            //组内记录列表
            List({ space: CommonConstants.SPACE_4 }) {
              ForEach(group.items, (item: RecordModel) => {
                ListItem() {
                  Row({ space: CommonConstants.SPACE_4 }) {
                    Image(item.recordItem.image).width(50)
                    Column({ space: CommonConstants.SPACE_4 }) {
                      Text(item.recordItem.name)
                        .fontWeight(CommonConstants.FONT_WEIGHT_500)
                      Text(`${item.amount}${item.recordItem.unit}`)
                        .grayText()
                    }

                    Blank()
                    Text(`${item.calorie.toFixed(0)}千卡`).grayText()
                  }
                  .width('100%')
                  .padding(CommonConstants.SPACE_6)
                }.swipeAction({ end: this.deleteButton})
              })
            }
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(CommonConstants.DEFAULT_18)
          .padding(CommonConstants.SPACE_12)
        }
      }

      )
    }

    .width(CommonConstants.THOUSANDTH_940)
    .margin({ top: 10 })
  }

  @Builder
  deleteButton() {
    Image($r('app.media.ic_public_delete_filled'))
      .width(20)
      .fillColor(Color.Red)
      .margin(5)
  }
}