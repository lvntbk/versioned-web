# Versioned Web
Docker · Kubernetes · Helm · GitHub Actions · CI/CD · Rollback

Bu proje, **sürüm (version) bazlı bir release ve rollback akışını** uçtan uca göstermek amacıyla hazırlanmış basit ama gerçekçi bir örnektir.  
Uygulama, çalıştığı Docker image sürümünü (vX.Y.Z) web arayüzünde gösterir.

Her yeni sürüm:
- Docker image olarak build edilir
- Kubernetes ortamında Helm ile deploy edilir
- Gerekirse önceki stabil sürüme **tek komutla rollback** yapılabilir

---

## 🎯 Projenin Amacı

- Docker image’larını **versiyon etiketleri (tag)** ile yönetmek  
- Kubernetes üzerinde **Helm** kullanarak deployment yapmak  
- **GitHub Actions** ile CI sürecini otomatikleştirmek  
- Hatalı bir release sonrası **rollback pratiğini** göstermek  

---

## 🧱 Kullanılan Teknolojiler

- Docker  
- Kubernetes (k3d)  
- Helm  
- GitHub Actions  
- GitHub Container Registry (GHCR)  
- Nginx (statik web sunucusu)


## 🚀 Local Ortamda Çalıştırma (k3d)

### 1️⃣ Kubernetes Cluster Oluşturma
```bash
k3d cluster create vweb --agents 1 --servers 1
export VERSION=v1.0.0
docker build -t versioned-web:$VERSION --build-arg VERSION=$VERSION .
k3d image import versioned-web:$VERSION -c vweb
helm upgrade --install versioned-web ./helm --set image.tag=$VERSION
kubectl port-forward svc/versioned-web 18080:80
Tarayıcıdan:
http://localhost:18080
🔁 Versiyon Güncelleme (Upgrade)

Yeni bir sürüm çıkarmak için:

export VERSION=v1.0.1
docker build -t versioned-web:$VERSION --build-arg VERSION=$VERSION .
k3d image import versioned-web:$VERSION -c vweb

helm upgrade versioned-web ./helm --set image.tag=$VERSION
kubectl rollout status deploy/versioned-web


Sayfa yenilendiğinde:

Version: v1.0.1
🤖 CI Süreci (GitHub Actions)

Bu projede tag bazlı CI yaklaşımı kullanılmıştır.

Yeni bir sürüm yayınlamak için:

git tag v1.0.2
git push origin v1.0.2


Bu işlem sonrası:

GitHub Actions otomatik çalışır

Docker image build edilir

Image GitHub Container Registry (GHCR)’a push edilir

Oluşan image:

ghcr.io/<github-kullanici-adi>/versioned-web:v1.0.2

🔄 Rollback (Geri Alma) Demo

Önce Helm release geçmişini görüntüleyin:

helm history versioned-web


Önceki bir sürüme geri dönmek için (örnek: revision 2):

helm rollback versioned-web 2
kubectl rollout status deploy/versioned-web


Rollback sonrası uygulama, önceki stabil sürümle (örneğin v1.0.1) çalışmaya devam eder.

Bu işlem:

Servisi kesmeden

Güvenli bir şekilde

Kubernetes rollout mekanizması ile yapılır

✅ Bu Projede Gösterilenler

Version bazlı Docker image yönetimi

Helm ile Kubernetes deployment

GitHub Actions ile CI pipeline

Rollout & Rollback pratiği

Gerçek hayata uygun release süreci 

## 🗂️ Proje Yapısı

