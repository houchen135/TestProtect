//
//  FirstViewController.m
//  TestProtect
//
//  Created by xthink2 on 16/1/11.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (nonatomic,strong)NSInvocationOperation *operation;
@property (nonatomic,assign)int a;
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation FirstViewController
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    }
    return _imageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:LanguageAdaptation(@"0Title")];
    // Do any additional setup after loading the view.
//    [self creat4];
}
#pragma mark -------NSthread 多线程（1）--------
- (void)creat{
#pragma mark - 初始化
    // (1)动态创建
    // - (id)initWithTarget:(id)target selector:(SEL)selector object:(id)argument;
    // selector ：线程执行的方法，这个selector最多只能接收一个参数
    // target ：selector消息发送的对象
    // argument : 传给selector的唯一参数，也可以是nil
    // 初始化线程
    NSThread *thread1 =[[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    // 设置线程的优先级（0.0 -1.0   1.0最高级）
    thread1.threadPriority =1;
    // 开启线程
    [thread1 start];
    
    
    // (2)静态创建
    // + (void)detachNewThreadSelector:(SEL)selector toTarget:(id)target withObject:(id)argument;
    // 调用完毕后，会马上创建并开启新线程
//    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
    
    
    // (3)隐式创建
//    [self performSelectorInBackground:@selector(run) withObject:nil];
    
    
#pragma mark - 获取当前线程
    NSThread *current = [NSThread currentThread];
    NSLog(@"%@",current);
    
    
#pragma mark - 获取当前主线程
    NSThread *main =[NSThread mainThread];
    NSLog(@"%@",main);
    
#pragma mark - 暂停进程
    // 暂停2s
//    [NSThread sleepForTimeInterval:2];
    // 或者
//    NSDate *date = [NSDate dateWithTimeInterval:2 sinceDate:[NSDate date]];
//    [NSThread sleepUntilDate:date];
#pragma mark - 线程间的通信
    // (1)指定线程上操作
//    [self performSelector:@selector(run) onThread:thread1 withObject:nil waitUntilDone:YES];
    // (2)在主线程上操作
//    [self performSelectorOnMainThread:@selector(run) withObject:nil waitUntilDone:YES];
    // (3)当前线程上操作
//    [self performSelector:@selector(run) withObject:nil];
    
    
    
}


- (void)run{
    for (long  i =0; i<10; i++) {
        NSLog(@"%ld",i);
        [NSThread sleepForTimeInterval:2];
    }
    
}
#pragma mark -------NSOperation 多线程（2）--------
- (void)creat2{
#pragma mark - NSInvocationOperation创建
    _operation =[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run1) object:nil];
//    [_operation start];
#pragma mark - NSBlockOperation创建
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){
        NSLog(@"0执行了一个新的操作，线程：%@", [NSThread currentThread]);
    }];
    [operation1 addExecutionBlock:^() {
        NSLog(@"1又执行了1个新的操作，线程：%@", [NSThread currentThread]);
    }];
    [operation1 addExecutionBlock:^() {
        NSLog(@"2又执行了1个新的操作，线程：%@", [NSThread currentThread]);
    }];
    [operation1 addExecutionBlock:^() {
        NSLog(@"3又执行了1个新的操作，线程：%@", [NSThread currentThread]);
    }];
//    [operation1 start];
#pragma mark - 自定义NSOperation创建
    

}
- (void)run1{
    for ( self.a =0; self.a<10; self.a++) {
        NSLog(@"%d",self.a);
    }
    
}
#pragma mark -------NSOperationQueue 多线程（3）--------
- (void)creat3{
#pragma mark - 设置没有依赖的队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){
        NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^(){
        NSLog(@"执行第2次操作，线程：%@", [NSThread currentThread]);
    }];
    [queue addOperation:operation1];
    [queue addOperation:operation2];
#pragma mark - 设置有依赖的队列
    [operation1 addDependency:operation2];
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    
}
#pragma mark --------- GCD 多线程（3）----------
- (void)creat4
{
    [self.view addSubview:self.imageView];
#pragma mark - 获得全局并发Dispatch Queue (concurrent dispatch queue)
    // 获取默认优先级的全局并发dispatch queue
    // 并发dispatch queue可以同时并行地执行多个任务,不过并发queue仍然按先进先出的顺序来启动任务。
    // 第一个参数用于指定优先级，分别使用DISPATCH_QUEUE_PRIORITY_HIGH和DISPATCH_QUEUE_PRIORITY_LOW两个常量来获取高和低优先级的两个queue；第二个参数目前未使用到，默认0即可
    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t  queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_t  queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    NSLog(@"0>>%@\n1>>%@\n2>>%@",queue,queue1,queue2);
    
    
#pragma mark - 创建串行Dispatch Queue (serial dispatch queue)
    // 利用dispatch_queue_create函数创建串行queue,两个参数分别是queue名和一组queue属性
    dispatch_queue_t queueI;
    queueI = dispatch_queue_create("cn.itcast.queue", NULL);
    NSLog(@"I>>%@",queueI);
    
    
    
#pragma mark - 运行时获得公共Queue
    //1> 使用dispatch_get_current_queue函数作为调试用途,或者测试当前queue的标识。在block对象中调用这个函数会返回block提交到的queue(这个时候queue应该正在执行中)。在block对象之外调用这个函数会返回应用的默认并发queue。
    //2> 使用dispatch_get_main_queue函数获得应用主线程关联的串行dispatch queue
    //3> 使用dispatch_get_global_queue来获得共享的并发queue
    
#pragma mark - Dispatch Queue的内存管理
    // 1> Dispatch Queue和其它dispatch对象(还有dispatch source)都是引用计数的数据类型。当你创建一个串行dispatch queue时,初始引用计数为 1,你可以使用dispatch_retain和dispatch_release函数来增加和减少引用计数。当引用计数到达 0 时,系统会异步地销毁这个queue
    // 2> 对dispatch对象(如dispatch queue)retain和release 是很重要的,确保它们被使用时能够保留在内存中。和OC对象一样,通用的规则是如果使用一个传递过来的queue,你应该在使用前retain,使用完之后release
    // 3> 你不需要retain或release全局dispatch queue,包括全局并发dispatch queue和main dispatch queue
    // 4> 即使你实现的是自动垃圾收集的应用,也需要retain和release创建的dispatch queue和其它dispatch对象。GCD 不支持垃圾收集模型来回收内存
#pragma mark - 添加任务到queue
#pragma mark - 1.添加单个任务到queue
    // 1> 异步添加任务
    //  你可以异步或同步地添加一个任务到Queue,尽可能地使用dispatch_async或dispatch_async_f函数异步地调度任务。因为添加任务到Queue中时,无法确定这些代码什么时候能够执行。因此异步地添加block或函数,可以让你立即调度这些代码的执行,然后调用线程可以继续去做其它事情。特别是应用主线程一定要异步地 dispatch 任务,这样才能及时地响应用户事件
    // 2> 同步添加任务
    //  少数时候你可能希望同步地调度任务,以避免竞争条件或其它同步错误。 使用dispatch_sync和dispatch_sync_f函数同步地添加任务到Queue,这两个函数会阻塞当前调用线程,直到相应任务完成执行。注意：绝对不要在任务中调用 dispatch_sync或dispatch_sync_f函数,并同步调度新任务到当前正在执行的 queue。对于串行queue这一点特别重要,因为这样做肯定会导致死锁;而并发queue也应该避免这样做。
    // 调用前，查看下当前线程
    NSLog(@"当前调用线程：%@", [NSThread currentThread]);
    
    // 创建一个串行queue
    dispatch_queue_t queueII = dispatch_queue_create("cn.itcast.queue", NULL);
    
    dispatch_async(queueII, ^{
        NSLog(@"a>>开启了一个异步任务，当前线程：%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queueII, ^{
        NSLog(@"b>>开启了一个同步任务，当前线程：%@", [NSThread currentThread]);
    });
    // 销毁队列  
//    dispatch_release(queueII);
#pragma mark - 2.并发地执行循环迭代
    // 如果你使用循环执行固定次数的迭代, 并发dispatch queue可能会提高性能。
    // 例如下面的for循环：
    int i;
    int count = 10;
    for (i = 0; i < count; i++) {
        printf("%d  ",i);
    }
    
    // 1> 如果每次迭代执行的任务与其它迭代独立无关,而且循环迭代执行顺序也无关紧要的话,你可以调用dispatch_apply或dispatch_apply_f函数来替换循环。这两个函数为每次循环迭代将指定的block或函数提交到queue。当dispatch到并发 queue时,就有可能同时执行多个循环迭代。用dispatch_apply或dispatch_apply_f时你可以指定串行或并发 queue。并发queue允许同时执行多个循环迭代,而串行queue就没太大必要使用了。
    // 下面代码使用dispatch_apply替换了for循环,你传递的block必须包含一个size_t类型的参数,用来标识当前循环迭代。第一次迭代这个参数值为0,最后一次值为count - 1
    // 获得全局并发queue
    dispatch_queue_t queueIII = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    size_t count1 = 10;
    dispatch_apply(count1, queueIII, ^(size_t i) {
        printf(">>>>%zd ", i);
    });
    // 可以看出，这些迭代是并发执行的
    //  和普通for循环一样,dispatch_apply和dispatch_apply_f函数也是在所有迭代完成之后才会返回，因此这两个函数会阻塞当前线程，主线程中调用这两个函数必须小心,可能会阻止事件处理循环并无法响应用户事件。所以如果循环代码需要一定的时间执行,可以考虑在另一个线程中调用这两个函数。如果你传递的参数是串行queue,而且正是执行当前代码的queue,就会产生死锁。
    // 销毁队列
//    dispatch_release(queue);
#pragma mark - 3.在主线程中执行任务  
    //1> GCD提供一个特殊的dispatch queue,可以在应用的主线程中执行任务。只要应用主线程设置了run loop(由CFRunLoopRef类型或NSRunLoop对象管理),就会自动创建这个queue,并且最后会自动销毁。非Cocoa应用如果不显式地设置run loop, 就必须显式地调用dispatch_main函数来显式地激活这个dispatch queue，否则虽然你可以添加任务到queue,但任务永远不会被执行。
    //2> 调用dispatch_get_main_queue函数获得应用主线程的dispatch queue,添加到这个queue的任务由主线程串行化执行
    //3> 代码实现，比如异步下载图片后，回到主线程显示图片
    
#pragma mark -⭐️异步下载图片⭐️
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://car0.autoimg.cn/upload/spec/9579/u_20120110174805627264.jpg"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        // 回到主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });  
    });
#pragma mark -⭐️Dispatch Group的使用⭐️
    // 假设有这样一个需求：从网络上下载两张不同的图片，然后显示到不同的UIImageView上去，一般可以这样实现
    [self downloadImages1];
    // 虽然这种方案可以解决问题，但其实两张图片的下载过程并不需要按顺序执行，并发执行它们可以提高执行速度。有个注意点就是必须等两张图片都下载完毕后才能回到主线程显示图片。Dispatch Group能够在这种情况下帮我们提升性能。下面先看看Dispatch Group的用处：我们可以使用dispatch_group_async函数将多个任务关联到一个Dispatch Group和相应的queue中，group会并发地同时执行这些任务。而且Dispatch Group可以用来阻塞一个线程, 直到group关联的所有的任务完成执行。有时候你必须等待任务完成的结果,然后才能继续后面的处理。
    [self downloadImages2];
}
- (UIImage *)imageWitchURLString:(NSString *)urlString{
    NSURL *url =[NSURL URLWithString:urlString];
    NSData *data =[NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:data];
}

- (void)downloadImages1{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 下载第一张图片
        NSString *url1 =@"http://car0.autoimg.cn/upload/spec/9579/u_20120110174805627264.jpg";
        UIImage *image1 =[self imageWitchURLString:url1];
        // 下载第二张图片
        NSString *url2 =@"http://car0.autoimg.cn/upload/spec/9579/u_20120110174805627264.jpg";
        UIImage *image2 =[self imageWitchURLString:url2];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"1>>>%@\n2>>>%@",image1,image2);
        });
    });
}
- (void)downloadImages2{
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        // 创建一个组
        dispatch_group_t group =dispatch_group_create();
        __block UIImage *image1 =nil;
        __block UIImage *image2 =nil;
        // 关联一个任务到group
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0 ), ^{
            NSString *url1 =@"";
            image1 =[self imageWitchURLString:url1];
        });
        // 关联第二个任务到group
       dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           NSString *url2 =@"";
           image2 =[self imageWitchURLString:url2];
       });
        // 等待组中的任务执行完毕,回到主线程执行block回调
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"*1>>>%@\n*2>>>%@",image1,image2);
            // 千万不要在异步线程中自动释放UIImage，因为当异步线程结束，异步线程的自动释放池也会被销毁，那么UIImage也会被销毁
        });
        
    });
    
    
    
}


















- (void)didReceiveMemoryWarning {
    
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
