import BreakpointType from '../../bean/BreanpointType'
import BreakpointConstants from '../../constants/BreakpointConstants'
import { CommonConstants } from '../../constants/CommonConstants'
import RecordService from '../../service/RecordService'
import DateUtil from '../../utils/DateUtil'
import RecordVO from '../../model/RecordModel'
import StatsInfo from '../../model/StatsInfoModel'
import CalorieStats from './CalorieStats'
import DatePickDialog from './DatePickDialog'
import NutrientStats from './NutrientStats'

@Component
export default struct StatsCard {
  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM
  @Consume
  @Watch('handleRecordsChange')
  records: RecordVO[]
  @State info: StatsInfo = new StatsInfo()

  handleRecordsChange() {
    this.info = RecordService.calculateStatsInfo(this.records)
  }

  controller: CustomDialogController = new CustomDialogController({
    builder: DatePickDialog({ selectedDate: new Date(this.selectedDate) })
  })

  build() {
    Column() {
      //日期
      Row({ space: CommonConstants.DEFAULT_12 }) {
        Text(DateUtil.formatDate(this.selectedDate))
          .fontColor($r('app.color.secondary_color'))
        Image($r('app.media.ic_public_spinner'))
          .width(20)
          .fillColor($r('app.color.secondary_color'))

      }.padding(CommonConstants.SPACE_8)
      .onClick(() => {
        this.controller.open()
      })

      //统计信息
      Swiper() {
        //2.1热量统计
        CalorieStats({ intake: this.info.intake, expend: this.info.expend })
        NutrientStats({ carbon: this.info.carbon, protein: this.info.protein, fat: this.info.fat })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(CommonConstants.DEFAULT_18)
      .indicator(new DotIndicator().selectedColor($r('app.color.primary_color')))
      .displayCount(new BreakpointType({
        sm: 1,
        md: 1,
        lg: 2,
      }).getValue(this.currentBreakpoint))
    }.width(CommonConstants.THOUSANDTH_940)
    .backgroundColor($r('app.color.stats_title_bgc'))
    .borderRadius(CommonConstants.DEFAULT_18)
  }
}