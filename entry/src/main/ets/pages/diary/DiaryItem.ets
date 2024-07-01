import router from '@ohos.router'
import prompt from '@ohos.prompt'
import { Diary } from '../../bean/Diary'
import { DiaryService} from '../../service/DiaryService'

@Component
export default struct DiaryItem {
  @State diary: Diary | undefined = undefined
  @Link diaryAPI: DiaryService
  @Link listData: Diary[]
  @Link count: number

  build() {
    Row() {
      Image($r('app.media.icon'))
        .size({ width: 25, height: 25 })
        .objectFit(ImageFit.Contain)
      Column() {
        Text(this.diary!!.title)
          .fontColor(Color.Black)
          .fontSize(25)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(this.diary!!.content)
          .fontColor(Color.Gray)
          .margin({ top: 10 })
          .fontSize(20)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }.alignItems(HorizontalAlign.Start)
      .margin({ left: 20 })
      .width('80%')

      Blank()
      Image($r('app.media.icon'))
        .size({ width: 30, height: 30 })
        .objectFit(ImageFit.Contain)
        .onClick(() => {
          this.delete()
        })
    }
    .padding(10)
    .width('100%')
    .borderRadius(16)
    .backgroundColor(Color.White)
    .onClick(() => {
      router.push({
        url: 'pages/edit',
        params: {
          diary: this.diary
        }
      })
    })
  }

  delete() {
    this.diaryAPI.deleteByKID(this.diary!!.date, (result:string) => {
      prompt.showToast({ message: result, duration: 3000, bottom: '30%' });
      if (result === "删除成功！") {
        let index = this.listData.indexOf(this.diary!!)
        if (index >= 0) {
          this.listData.splice(index, 1)
          this.count = this.listData.length
        }
      }
    })
  }
}