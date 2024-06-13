import { CommonConstants } from '../../constants/CommonConstants'
import AddressAreaComp from '../../view/weather/AddressAreaComp'
import AqiAreaComp from '../../view/weather/AqiAreaComp'
import ListDailyAreaComp from '../../view/weather/ListDailyAreaComp'
import ListHourAreaComp from '../../view/weather/ListHourAreaComp'
import NowAreaComp from '../../view/weather/NowAreaComp'

@Component
export struct WeatherIndex {
  @State city: string = ''

  build() {
    Column({ space: CommonConstants.SPACE_8 }) {
      AddressAreaComp({ city: $city }).height('5%')
      // NowAreaComp({ city: $city }).height('15%')
      // AqiAreaComp({ city: $city }).height('15%')
      // ListHourAreaComp({ city: $city }).height('12%')
      // ListDailyAreaComp({ city: $city })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.index_page_background'))
    .backgroundImageSize(ImageSize.Cover)
    .alignItems(HorizontalAlign.Start)
    .backgroundImagePosition(Alignment.Center)
  }
}