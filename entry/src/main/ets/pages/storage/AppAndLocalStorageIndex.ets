AppStorage.SetOrCreate('PropA', 47);
let localStorage = new LocalStorage({ 'PropA': 48 });

@Entry(localStorage)
@Component
struct CompA {
  @StorageLink('PropA') storeLink: number = 1;
  @LocalStorageLink('PropA') localStoreLink: number = 1;

  build() {
    Column({ space: 20 }) {
      Text(`From AppStorage ${this.storeLink}`)
        .onClick(() => this.storeLink += 1)
      Text(`From LocalStorage ${this.localStoreLink}`)
        .onClick(() => this.localStoreLink += 1)
    }
  }
}