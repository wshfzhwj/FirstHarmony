import { CommonConstants } from '../../constants/CommonConstants'
import GroupInfo from '../../model/GroupInfoModel'
import ItemCategoryModel from '../../model/ItemCategoryModel'
import RecordItem from '../../model/RecordItemModel'
import ItemViewModel from '../../viewmodel/ItemViewModel'

@Component
export default struct ItemList {
  showPanel: (item: RecordItem) => void = () => {
  }
  @Prop isFood: boolean

  build() {
    Tabs() {
      TabContent() {
        this.TabContentBuilder(ItemViewModel.list(this.isFood))
      }
      .tabBar('全部')

      ForEach(
        ItemViewModel.listItemGroupByCategory(this.isFood),
        (group: GroupInfo<ItemCategoryModel, RecordItem>) => {
          TabContent() {
            this.TabContentBuilder(group.items)
          }
          .tabBar(group.type.name)
        })

    }
    .width(CommonConstants.THOUSANDTH_940)
    .height('100%')
    .barMode(BarMode.Scrollable)
  }

  @Builder
  TabContentBuilder(items: RecordItem[]) {
    List({ space: CommonConstants.SPACE_10 }) {
      ForEach(items, (item: RecordItem) => {
        ListItem() {
          Row({ space: CommonConstants.SPACE_6 }) {
            Image(item.image).width(50)
            Column({ space: CommonConstants.SPACE_4 }) {
              Text(item.name)
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
              Text(`${item.calorie}千卡/${item.unit}`)
                .fontSize(14)
                .fontColor($r('app.color.light_gray'))
            }.alignItems(HorizontalAlign.Start)

            Blank()
            Image($r('app.media.ic_public_add_norm_filled'))
              .width(18)
              .fillColor($r('app.color.primary_color'))
          }
          .width('100%')
          .padding(CommonConstants.SPACE_6)
        }
        .onClick(() => this.showPanel(item))
      })
    }
    .width('100%')
    .height('100%')
  }
}