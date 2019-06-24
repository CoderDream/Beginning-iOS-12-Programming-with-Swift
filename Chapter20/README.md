




```
2019-06-24 09:26:33.178325+0800 FoodPin[10110:904643] Warning: Attempt to present <FoodPin.ReviewViewController: 0x117dc5df0>  on <FoodPin.RestaurantDetailViewController: 0x101e462b0> which is already presenting (null)
2019-06-24 09:26:34.284099+0800 FoodPin[10110:904643] -[_UIFullscreenPresentationController adaptivePresentationController]: unrecognized selector sent to instance 0x117da33f0
2019-06-24 09:26:34.305494+0800 FoodPin[10110:904643] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[_UIFullscreenPresentationController adaptivePresentationController]: unrecognized selector sent to instance 0x117da33f0'
*** First throw call stack:
(0x1b93d4518 0x1b85af9f8 0x1b92f1278 0x1b93d9d60 0x1b93db9fc 0x1e5844494 0x1e5828610 0x1e515b490 0x1e57defdc 0x1e57cdb2c 0x1e57fa744 0x1b936589c 0x1b93605c4 0x1b9360b40 0x1b9360354 0x1bb56079c 0x1e57d3b68 0x100d90858 0x1b8e268e0)
libc++abi.dylib: terminating with uncaught exception of type NSException

```


- [UISearchController使用总结](https://blog.csdn.net/u011656331/article/details/84669634)

```
// ***这行代码非常重要，一定要加上***
self.definesPresentationContext = true
```
