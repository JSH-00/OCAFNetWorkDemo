//
//  ViewController.m
//  OCAFNetWorkDemo
//
//  Created by JSH on 2021/8/22.
//

#import "ViewController.h"
#import<AFNetworking/AFNetworking.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageNetView = [UIImageView new];
    [self.view addSubview: imageNetView];
    imageNetView.frame = CGRectMake(200, 200, 200, 200);

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /* 知识点1：设置AFN采用什么样的方式来解析服务器返回的数据*/

     //如果返回的是XML，那么告诉AFN，响应的时候使用XML的方式解析
    // manager.responseSerializer = [AFXMLParserResponseSerializer serializer];

     //如果返回的就是二进制数据，那么采用默认二进制的方式来解析数据（HTTP）
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];

     //采用JSON的方式来解析数据
     //manager.responseSerializer = [AFJSONResponseSerializer serializer];
     
      //指定接收信号为image/png
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"image/png"];
     
     [manager GET:@"https://search-operate.cdn.bcebos.com/9dfdb7a4fa9dab231f5dd9b90dc91597.png" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@---%@",[responseObject class],responseObject);
         imageNetView.image = [UIImage imageWithData:responseObject]; //NSData转UIimage

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
    }];


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 [self post];
}

-(void)get {
    NSMutableArray *responseArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"]; //指定接收信号为text/html
    
    [manager GET:@"https://zerozero.tech/api/v1/showcase/no-scene.json?skip=0&take=10" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@---%@",[responseObject class], responseObject);
        [responseArray addObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Response fialue!!!");
    }];
}

- (void)post {
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/json",@"text/plain", nil];
    
    //2.创建参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"phoneAreaCode" forKey:@"86"];
    [dict setObject:@"phoneNumber" forKey:@"13766666666"];
    [dict setObject:@"password" forKey:@"12345678"];
    //3.发送POST请求
    [manager POST:@"http://cn.test.api.gethover.com/api/auth/login/phone"
       parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功%@---%@",[responseObject class], responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败---%@",error);
    }];
}

@end
