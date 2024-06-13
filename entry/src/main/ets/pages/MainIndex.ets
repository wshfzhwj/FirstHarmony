import BreakpointType from '../bean/BreanpointType';
import BreakpointConstants from '../constants/BreakpointConstants';
import { CommonConstants } from '../constants/CommonConstants';
import BreakpointSystem from '../utils/BreakpointSystem';
import {WeatherIndex } from './weather/WeatherIndex';
import { HomeIndex } from './home/HomeIndex';
import RecordIndex from '../view/record/RecordIndex';
import { UserIndex } from './user/UserIndex';
import NotificationIndex from './notification/NotificationIndex';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private breakpointSystem: BreakpointSystem = new BreakpointSystem()
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM
  @State isPageShow: boolean = false

  aboutToAppear() {
    this.breakpointSystem.register()
  }

  onPageShow(){
    this.isPageShow = true
  }

  onPageHide(){
    this.isPageShow = false
  }

  aboutToDisappear() {
    this.breakpointSystem.unregister()
  }

  @Builder TabBarBuilder(title: ResourceStr, image: ResourceStr, index: number) {
    Column({ space: CommonConstants.SPACE_8 }) {
      Image(image)
        .width(22)
        .fillColor(this.selectColor(index))
      Text(title)
        .fontSize(14)
        .fontColor(this.selectColor(index))
    }
  }

  build() {
    Tabs({ barPosition: BreakpointConstants.BAR_POSITION.getValue(this.currentBreakpoint)}) {
      TabContent() {
        RecordIndex({isPageShow:this.isPageShow})
      }.tabBar(this.TabBarBuilder($r('app.string.tab_record'), $r('app.media.ic_calendar'), 0))

      TabContent() {
        WeatherIndex()
      }.tabBar(this.TabBarBuilder($r('app.string.tab_weather'), $r('app.media.discover'), 1))

      TabContent() {
        NotificationIndex()
      }.tabBar(this.TabBarBuilder($r('app.string.tab_user'), $r('app.media.ic_user_portrait'), 2))

      TabContent() {
        HomeIndex()
      }.tabBar(this.TabBarBuilder($r('app.string.tab_home'), $r('app.media.ic_home'), 3))
    }
    .width('100%')
    .height('100%')
    .onChange(index => this.currentIndex = index)
    .vertical(new BreakpointType({
      sm: false,
      md: true,
      lg: true
    }).getValue(this.currentBreakpoint))
  }



  selectColor(index:number){
     return this.currentIndex === index ? $r('app.color.primary_color') : $r('app.color.gray')
  }

  chooseBarPosition() {
    return new BreakpointType({
      sm: BarPosition.End,
      md: BarPosition.Start,
      lg: BarPosition.Start,
    })[this.currentBreakpoint]
  }

}





