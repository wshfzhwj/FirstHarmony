import distributedKVStore from '@ohos.data.distributedKVStore';

export class DiaryKV {
  public kvStore: distributedKVStore.SingleKVStore = undefined;
  public kvManager: distributedKVStore.KVManager = undefined;

  async initKvStore() {
    if ((typeof (this.kvStore)) != 'undefined') {
      return;
    }

    var config: distributedKVStore.KVManagerConfig = {
      bundleName: 'com.saint.myapplication',
      context: getContext(this),
    }
    console.log('[DiaryKV] createKVManager begin')
    this.kvManager = await distributedKVStore.createKVManager(config)
    console.log('[DiaryKV] createKVManager end')

    let options = {
      createIfMissing: true,
      encrypt: false,
      backup: false,
      kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION,
      securityLevel: distributedKVStore.SecurityLevel.S1,
    }
    console.log('[DiaryKV] kvManager.getKVStore begin')
    this.kvStore = await this.kvManager.getKVStore('storeId', options);
    console.log('[DiaryKV] kvManager.getKVStore end')
  }
}
