import router from '@ohos.router'
@Entry
@Component
struct StorageLinkBPage {
  @StorageProp('count1') nextCount1: number = 0//单向绑定
  @StorageProp('count2') nextCount2: number = 0//单向绑定
  private label: string = '单击'

  build() {
    Column({space:20}) {
      Text('当前页面是 B Page').fontSize(30)
      Button(`${this.label}`)
        .onClick(()=>{
          var v = AppStorage.Get<number>('count1')
          AppStorage.Set('count1',v+1)
          this.nextCount2++
        })
      Text(`nextCount1:${this.nextCount1}`).fontSize(25);
      Text(`nextCount2:${this.nextCount2}`).fontSize(25);

      Text(`count1: ${AppStorage.Get<number>('count1').toString()}`).fontSize(25);
      Text(`count2: ${AppStorage.Get<number>('count2').toString()}`).fontSize(25);

      Button('返回')
        .onClick(()=>{
          router.back()
        })
    }.width('100%').padding(20)
    .backgroundColor(0xccFFcc)
  }
}