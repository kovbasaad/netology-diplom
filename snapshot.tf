
resource "yandex_compute_snapshot" "vm-1disk" {
  name           = "vm1-snapshot"
  source_disk_id = yandex_compute_instance.vm-1.boot_disk[0].disk_id

}

resource "yandex_compute_snapshot" "vm-2disk" {
  name           = "vm2-snapshot"
  source_disk_id = yandex_compute_instance.vm-2.boot_disk[0].disk_id

}

resource "yandex_compute_snapshot" "vm-3disk" {
  name           = "vm3-snapshot"
  source_disk_id = yandex_compute_instance.vm-3.boot_disk[0].disk_id

}

resource "yandex_compute_snapshot" "vm-4disk" {
  name           = "vm4-snapshot"
  source_disk_id = yandex_compute_instance.vm-4.boot_disk[0].disk_id

}

resource "yandex_compute_snapshot" "vm-5disk" {
  name           = "vm5-snapshot"
  source_disk_id = yandex_compute_instance.vm-5.boot_disk[0].disk_id

}

resource "yandex_compute_snapshot" "vm-6disk" {
  name           = "vm6-snapshot"
  source_disk_id = yandex_compute_instance.vm-6.boot_disk[0].disk_id

}

resource "yandex_compute_snapshot" "vm-7disk" {
  name           = "vm7-snapshot"
  source_disk_id = yandex_compute_instance.vm-7.boot_disk[0].disk_id

}

resource "yandex_compute_snapshot_schedule" "wsnapschedule" {
  name           = "wsnapshotschedule"

  schedule_policy {
    expression = "0 0 * * SUN"
  }

  snapshot_count = 1

  snapshot_spec {
      description = "weekly-snapshot"
  }

  disk_ids = ["${yandex_compute_instance.vm-1.boot_disk[0].disk_id}", "${yandex_compute_instance.vm-2.boot_disk[0].disk_id}", "${yandex_compute_instance.vm-3.boot_disk[0].disk_id}", "${yandex_compute_instance.vm-4.boot_disk[0].disk_id}", "${yandex_compute_instance.vm-5.boot_disk[0].disk_id}", "${yandex_compute_instance.vm-6.boot_disk[0].disk_id}", "${yandex_compute_instance.vm-7.boot_disk[0].disk_id}"]
}
