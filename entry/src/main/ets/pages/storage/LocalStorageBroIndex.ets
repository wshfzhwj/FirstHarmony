let storage2 = new LocalStorage({ countStorage: 1 });

@Component
struct BroChild {
  // 子组件实例的名字
  label: string = 'no name';
  // 和LocalStorage中“countStorage”的双向绑定数据
  @LocalStorageLink('countStorage') playCountLink: number = 0;

  build() {
    Row() {
      Text(this.label)
        .width(50)
        .height(60)
        .fontSize(12)
      Text(`playCountLink ${this.playCountLink}: inc by 1`)
        .onClick(() => {
          this.playCountLink += 1;
        })
        .width(200).height(60).fontSize(12)
    }.width(300).height(60)
  }
}

@Entry(storage2)
@Component
struct Parent {
  @LocalStorageLink('countStorage') playCount: number = 0;

  build() {
    Column() {
      Row() {
        Text('Parent')
          .width(50).height(60).fontSize(12)
        Text(`playCount ${this.playCount} dec by 1`)
          .onClick(() => {
            this.playCount -= 1;
          })
          .width(250).height(60).fontSize(12)
      }.width(300).height(60)

      Row() {
        Text('LocalStorage')
          .width(50).height(60).fontSize(12)
        Text(`countStorage ${this.playCount} incr by 1`)
          .onClick(() => {
            storage2.set<number>('countStorage', 1 + storage2.get<number>('countStorage'));
          })
          .width(250).height(60).fontSize(12)
      }.width(300).height(60)

      BroChild({ label: 'ChildA' })
      BroChild({ label: 'ChildB' })
      //${storage2.get<number>('countStorage')}使用没渲染  其实变量已经改变
      //Text组件“playCount in LocalStorage for debug ${storage.get(‘countStorage’)}”没有同步刷新，
      // 因为storage.get(‘countStorage’)返回的是常规变量，常规变量的更新并不会引起Text组件的重新渲染。
      Text(`playCount in LocalStorage for debug ${storage2.get<number>('countStorage')}`)
        .width(300).height(60).fontSize(12)
    }
  }
}