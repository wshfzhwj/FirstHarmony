import router from '@ohos.router';
import prompt from '@ohos.prompt';
import { Diary } from '../../diary/Diary';
import DiaryItem from './DiaryItem';
import hilog from '@ohos.hilog';
import distributedKVStore from '@ohos.data.distributedKVStore';
import { DiaryAPI } from '../../diary/DiaryAPI';

@Entry
@Component
struct DiaryIndex {
  @State message: string = '我的日记'
  @State count: number = 0
  @State listData: Diary[] = []
  config: distributedKVStore.KVManagerConfig = {
    bundleName: 'com.saint.myapplication',
    context: getContext(this),
  }
  @State diaryAPI: DiaryAPI = new DiaryAPI();

  onPageShow() {
    if (router.getParams() != null) {
      let msg : string = router.getParams()['msg']
      if (msg != null) {
        prompt.showToast({
          message: msg,
          duration: 3000,
          bottom: '30%'
        });
      }
    }

  }

  freshAll() {
    this.diaryAPI.queryAll((result: []) => {
      console.log('DiaryIndex freshAll callback...')
      this.count = result.length
      this.listData = <Diary[]> result
    })
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
        Text("篇数：")
          .fontSize(25).margin({ left: 25 })
        Text(`${this.count}`).fontSize(25)
        Blank()
        Button("刷新")
          .margin({ right: 15 })
          .fontSize(20)
          .padding(10)
          .onClick(() => {
            this.freshAll()
          })
          .width('30%')
      }.width('100%')
      .padding(5)

      // List({ space: 5 }) {
      //   ForEach(this.listData, (item) => {
      //     ListItem() {
      //       DiaryItem({ diary: item, diaryAPI: $diaryAPI, listData: $listData, count: $count })
      //     }
      //   })
      // }
      // .backgroundColor(0xEEEEEE)
      // .width('95%')
      // .margin(5)
      // .padding(5)
      // .layoutWeight(1)
      // .scrollBar(BarState.Auto)
      // .alignListItem(ListItemAlign.Start)

      Row() {
        Button('同步日记')
          .fontSize(20)
          .padding(10)
          .margin(5)
          .onClick(() => {
            this.freshAll()
          })
          .width('40%')
        Button('添加日记')
          .fontSize(20)
          .padding(10)
          .margin(5)
          .onClick(() => {
            let option = {
              url: "pages/diary/add"
            }
            router.pushUrl(option)
          })
          .width('40%')
      }
    }
  }

  sync() {
    // this.diaryAPI.sync()
  }
}

// @Component
// struct Header {
//   private title:ResourceStr
//   private
//   build() {
//     Row(){
//       Image('').width(30)
//       Text(this.title)
//       Blank()
//       Image('')
//     }.width('100%').height(30).margin({bottom:20})
//   }
// }