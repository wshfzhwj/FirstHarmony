import promptAction from '@ohos.promptAction'
import RecordService from '../../service/RecordService'
import DateUtil from '../../utils/DateUtil'
import RecordVO from '../../model/RecordModel'
import RecordList from './RecordList'
import SearchHeader from './SearchHeader'
import StatsCard from './StatsCard'

@Component
export default struct RecordIndex {
  @StorageProp('selectedDate')
  @Watch('aboutToAppear')
  selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  @Provide records: RecordVO[] = []
  @Prop
  @Watch('handlerPageShow')
  isPageShow: boolean

  async aboutToAppear() {
    this.records = await RecordService.queryRecordByDate(this.selectedDate)
  }

  handlerPageShow() {
    if (this.isPageShow) {
      this.aboutToAppear()
    }
  }

  build() {
    Column() {
      SearchHeader()
      StatsCard()
      RecordList()
        .layoutWeight(1)
    }.width('100%')
    .height('100%')
    .backgroundColor($r('app.color.index_page_background'))
  }
}