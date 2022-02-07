# Week 5 Homeworks
### Homework 1) Onboarding Screen:

[PageViewController](https://github.com/humeyrasahin7/TurkcellHomeworks/blob/master/week05/OnboardingScreen/OnboardingScreen/OnboargingPageViewController.swift) , [Custom xib viewController](https://github.com/humeyrasahin7/TurkcellHomeworks/blob/master/week05/OnboardingScreen/Onboarding/OnboardingViewController.swift)

<img src="https://github.com/humeyrasahin7/TurkcellHomeworks/blob/master/week05/onboarding.gif" width="300" height="690">

### Homework 2) viewcontroller yaşam döngüsünü araştırınız. Her biri için neler kullanılabilir örnek vermeye çalışınız.
**viewDidLoad:**
Bu fonksiyon bir UIViewController’ın hayat döngüsünde *yalnızca 1 defa* çalışır. Çağırıldığı zaman, ViewController’ınız oluşturulduğunu ve kendisine bağlı tüm IBOutlet’lerin hazır hale geldiğini bilirsiniz.

**viewWillAppear:**
UIViewController görünmeden hemen önce çağrılır. Alanları gizlemek / göstermek veya ekranın görünmesinden önce her defasında olmasını istediğiniz işlemler için uygundur.

**viewDidAppear:**
UIViewController görüntülendikten hemen sonra çağrılır. Bir animasyonu başlatmak veya bir API’dan verilerin yüklenmeye başlaması için uygun bir noktadır.

**viewWillDisappear:**
UIViewController ekrandan kaybolmadan hemen önce çalışır. viewWillAppear gibi bu fonksiyonda bir UIViewController objesinin hayat döngüsü boyunca birden fazla kez çalışabilir. Kullanıcı farklı bir sayfaya geçmeye başladığında çalışır.

**viewDidDisappear:**
Bir UIViewController ekrandan kaybolduktan sonra bu fonksiyon çalışır. Kaybolduktan sonra arkada çalışmaya devam etmesi istenmeyen işlemler için genellikle bu fonksiyon kullanılır.

### Homework 3) setviewcontrollers’a viewcontroller tanımlamak zorunda mıyız?
Evet çünkü definition'da "Set visible view controllers, optionally with animation. ***Array should only include view controllers*** that will be visible after the animation has completed." olarak belirtilmiş, array yalnızca viewcontroller tipini içerebilir.

### Homework 4) searchBar elle kelimeyi sillince tüm verileri geri getirmelisiniz, veri bulunmuyorsa custom empty view oluşturarak kullanıcıya göstermeliniz
