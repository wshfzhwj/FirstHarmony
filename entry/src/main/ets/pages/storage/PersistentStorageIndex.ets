PersistentStorage.persistProp('money',50)

@Entry
@Component
struct PersistentStoragePage {
  @State message: string = 'Hello PersistentStoragePage'
  @StorageLink('money') money:number = 10
  build() {
    Row() {
      Column({space:10}) {
        Text(this.message).fontSize(30)
        // 应用退出时会保存当前结果。重新启动后，会显示上一次的保存结果
        Text(`money:${this.money}`).fontSize(30).fontWeight(FontWeight.Bold)
          .onClick(()=>{
            this.money += 1
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}