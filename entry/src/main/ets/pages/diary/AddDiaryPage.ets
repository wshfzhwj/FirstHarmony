import router from '@ohos.router'
import prompt from '@ohos.prompt'
import { Diary } from '../../bean/Diary'
import systemDateTime from '@ohos.systemDateTime';
// import distributedKVStore from '@ohos.data.distributedKVStore';
import { diaryService as API } from '../../service/DiaryService';
import { promptAction } from '@kit.ArkUI';

export class WeatherInfo {
  value: string = ''
}

@Entry
@Component
struct AddPage {
  @State message: string = '添加日记'
  @State date: string = ''
  @State weather: string = ''
  @State title: string = ''
  @State content: string = ''
  private wArr: WeatherInfo[] = [{ value: '雪' }, { value: '阴' }, { value: '雨' }, { value: '雪' }]
  private diaryAPI = API

  onPageShow() {
    this.date = new Date().toDateString()
    this.weather = this.wArr[0].value
    this.title = ""
    this.content = ""
  }

  getWeatherSelected(): number {
    if (this.weather == this.wArr[0].value) {
      return 0
    } else if (this.weather == this.wArr[1].value) {
      return 1;
    } else if (this.weather == this.wArr[2].value) {
      return 2;
    } else if (this.weather == this.wArr[3].value) {
      return 3;
    }
    return 0
  }

  build() {
    Column() {
      Text(this.message)
        .fontSize(32)
        .padding(8)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(0xEEEEFF)
        .fontWeight(FontWeight.Bold)
      Row() {
        Text("今天：")
          .fontSize(20)
        Text(this.date)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text("天气:")
          .fontSize(20).margin({ left: 25 })
        Select(this.wArr)
          .selected(this.getWeatherSelected())
          .margin({ right: 20 })
          .font({ size: 20 })
          .selectedOptionFont({ size: 25 })
          .onSelect((index, value) => {
            this.weather = value
          })
      }.width('95%')

      Text("标题：")
        .fontSize(20).width('95%')
        .textAlign(TextAlign.Start)
      TextInput({ text: this.title })
        .width('95%')
        .onChange((v) => {
          this.title = v
        })
      Text("内容：")
        .fontSize(20).width('95%')
        .textAlign(TextAlign.Start)
      TextArea({ text: this.content })
        .width('95%')
        .layoutWeight(1)
        .onChange((v) => {
          this.content = v
        })
      Button("保存")
        .fontSize(20)
        .padding(10)
        .margin(5)
        .width('40%')
        .onClick(() => {
          this.add()
        })
    }.width('100%')
  }

  add() {
    if (!this.checkedInput()) {
      return
    }
    let d = new Diary(this.date, this.title, this.weather, this.content)
    this.diaryAPI.add(d, (result: Function) => {
      let option: router.RouterOptions = {
        url: "pages/diary/diaryIndex",
        params: {
          msg: result,
        }
      }
      router.back(option)
    })
  }

  checkedInput(): boolean {
    if (this.title.trim() != '' && this.content.trim() != '') {
      return true
    } else {
      promptAction.showToast({
        message: "标题和内容都不能为空",
        duration: 3000,
        bottom: '30%'
      });
      return false
    }
  }
}

class ResultInfo {
  msg: string = ''
}